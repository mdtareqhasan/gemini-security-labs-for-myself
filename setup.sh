#!/usr/bin/env bash
#
# gemini-security-labs: one command to get a fresh VM ready for the labs.
#
#   bash setup.sh
#
# What it does:
#   1. checks that Docker works
#   2. clones the Gemini security audit tool and pins it to a known commit
#   3. builds the audit image
#   4. copies the practice project into workspace/ (first run only)
#   5. puts a deliberately weak ~/.gemini/settings.json in place (first run only)
#
# It is safe to run this more than once. It never overwrites your work and it
# never uses sudo.

set -euo pipefail

# The upstream commit of https://github.com/aisecuritylabs-org/coding-agent-security
# that the labs are written against. Bump it here when you want a newer audit.
AUDIT_COMMIT="2031e5da6a0a086a5fbf1dcc0aea09dc0135b5eb"

UPSTREAM_URL="https://github.com/aisecuritylabs-org/coding-agent-security.git"
UPSTREAM_DIR="$HOME/coding-agent-security"

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE="$REPO_ROOT/workspace"
VULNERABLE="$REPO_ROOT/vulnerable-project"
HOME_SETTINGS_SRC="$REPO_ROOT/setup-assets/gemini-home-settings.json"
HOME_SETTINGS_DEST="$HOME/.gemini/settings.json"

AUDIT_IMAGE="gemini-audit"
BUILD_DIR="$HOME/.cache/gemini-security-labs"

say() {
  echo ""
  echo "==> $*"
}

note() {
  echo "    $*"
}

fail() {
  echo ""
  echo "ERROR: $*" >&2
  echo "" >&2
  exit 1
}

# sha256 of the upstream audit sources. The upstream launcher uses the same
# list and the same label, so it reuses the image built here instead of
# trying to build its own.
upstream_src_hash() {
  local sum
  if command -v sha256sum >/dev/null 2>&1; then sum=sha256sum; else sum="shasum -a 256"; fi
  cat \
    "$UPSTREAM_DIR/gemini/audit/Dockerfile" \
    "$UPSTREAM_DIR/gemini/audit/audit.sh" \
    "$UPSTREAM_DIR/gemini/audit/mappings.json" \
    "$UPSTREAM_DIR/common/audit-lib.sh" \
    "$UPSTREAM_DIR/common/jsonc.awk" \
    "$UPSTREAM_DIR/common/gitignore.sh" \
    | tr -d '\r' | $sum | cut -c1-16
}

echo "gemini-security-labs setup"
echo "==========================="

# --------------------------------------------------------------- step 1 ----
say "Step 1 of 5: checking Docker"

if ! command -v docker >/dev/null 2>&1; then
  fail "Docker is not installed or not on your PATH.

    The labs use the Gemini security audit, which runs inside a throwaway
    container. Without Docker the labs cannot run.

    On Ubuntu, install Docker Desktop or Docker Engine, then start it and
    check it works with:  docker info"
fi

if ! docker info >/dev/null 2>&1; then
  fail "Docker is installed but it is not working yet.

    Start Docker (Docker Desktop, or: sudo systemctl start docker) and then
    check it works with:  docker info

    You need to be able to run 'docker info' as your normal user, without sudo."
fi

note "Docker works: $(docker info --format '{{.ServerVersion}}' 2>/dev/null | head -n1)"

# --------------------------------------------------------------- step 2 ----
say "Step 2 of 5: getting the Gemini security audit tool"

if ! command -v git >/dev/null 2>&1; then
  fail "git is not installed. Install it with: sudo apt install git"
fi

if [ ! -d "$UPSTREAM_DIR/.git" ]; then
  note "Cloning the audit tool into $UPSTREAM_DIR (this takes a minute)"
  if ! git clone "$UPSTREAM_URL" "$UPSTREAM_DIR"; then
    fail "Could not clone $UPSTREAM_URL

    Check your internet connection, then run this script again."
  fi
else
  note "The audit tool is already at $UPSTREAM_DIR"
fi

# Make sure the pinned commit is there, even if the folder was cloned earlier.
if ! git -C "$UPSTREAM_DIR" cat-file -e "${AUDIT_COMMIT}^{commit}" 2>/dev/null; then
  note "Fetching the pinned commit"
  git -C "$UPSTREAM_DIR" fetch --tags origin >/dev/null 2>&1 || true
fi

if ! git -C "$UPSTREAM_DIR" cat-file -e "${AUDIT_COMMIT}^{commit}" 2>/dev/null; then
  fail "Could not find the pinned audit commit $AUDIT_COMMIT upstream.

    Run setup.sh again once you have a working internet connection."
fi

note "Checking out the pinned commit $AUDIT_COMMIT"
# core.autocrlf=false keeps the upstream bytes exactly as published. The
# upstream .gitattributes pins the line endings of *.sh, *.json and *.md,
# but not its awk helper, so a clone made on Windows can turn that helper
# into CRLF. The audit's awk then fails to parse, and the audit silently
# skips every check that reads a settings file.
git -C "$UPSTREAM_DIR" config core.autocrlf false
git -C "$UPSTREAM_DIR" checkout --force --detach "$AUDIT_COMMIT" >/dev/null

# --------------------------------------------------------------- step 3 ----
say "Step 3 of 5: building the audit image"

DOCKERFILE="$UPSTREAM_DIR/gemini/audit/Dockerfile"
BUILD_LOG="$(mktemp)"

if [ ! -f "$DOCKERFILE" ]; then
  fail "Could not find $DOCKERFILE

    The audit tool looks different than expected. Remove $UPSTREAM_DIR and
    run setup.sh again."
fi

note "Building the $AUDIT_IMAGE image (the first build takes a minute)"
if docker build -q --label "org.aisecuritylabs.src-hash=$(upstream_src_hash)" \
     -f "$DOCKERFILE" -t "$AUDIT_IMAGE" "$UPSTREAM_DIR" >"$BUILD_LOG" 2>&1; then
  note "The audit image is ready"
else
  # The upstream Dockerfile pins exact Alpine package versions. Alpine keeps
  # only the current revision in its stable repository, so a pin can go stale
  # and the image stops building. Repair that one pin in a copy of the
  # Dockerfile kept outside the upstream checkout. The audit itself, and the
  # upstream checkout, are left exactly as they are.
  note "The upstream image did not build, checking the pinned package versions"

  base_image="$(sed -n 's/^FROM[[:space:]][[:space:]]*\([^[:space:]]*\).*/\1/p' "$DOCKERFILE" | head -n1)"
  stale_pin="$(sed -n 's/.*yq-go=\([0-9A-Za-z._-]*\).*/\1/p' "$DOCKERFILE" | head -n1)"

  if [ -z "$base_image" ] || [ -z "$stale_pin" ]; then
    echo "" >&2
    echo "The last lines of the build output:" >&2
    tail -n 15 "$BUILD_LOG" >&2
    fail "Could not build the audit image. See the output above."
  fi

  current_pin="$(docker run --rm "$base_image" sh -c \
    'apk update >/dev/null 2>&1 && apk search -x yq-go | sed -n "s/^yq-go-\(.*\)$/\1/p" | head -n1' \
    2>/dev/null | tr -d '\r\n')"

  if [ -z "$current_pin" ]; then
    echo "" >&2
    echo "The last lines of the build output:" >&2
    tail -n 15 "$BUILD_LOG" >&2
    fail "Could not build the audit image, and the pinned package version
    could not be looked up. See the output above."
  fi

  note "Alpine serves yq-go $current_pin, the upstream image pins $stale_pin"
  note "Moving that one pin in a local copy of the Dockerfile so the image builds."
  note "The audit itself is not changed."

  mkdir -p "$BUILD_DIR"
  cp "$DOCKERFILE" "$BUILD_DIR/Dockerfile"
  sed -i "s/yq-go=$stale_pin/yq-go=$current_pin/" "$BUILD_DIR/Dockerfile"

  if ! docker build -q --label "org.aisecuritylabs.src-hash=$(upstream_src_hash)" \
       -f "$BUILD_DIR/Dockerfile" -t "$AUDIT_IMAGE" "$UPSTREAM_DIR" >"$BUILD_LOG" 2>&1; then
    echo "" >&2
    echo "The last lines of the build output:" >&2
    tail -n 15 "$BUILD_LOG" >&2
    fail "Could not build the audit image. See the output above."
  fi

  note "The audit image is ready"
  note "A local copy of the Dockerfile with the repaired pin is in $BUILD_DIR"
fi

rm -f "$BUILD_LOG"

# --------------------------------------------------------------- step 4 ----
say "Step 4 of 5: copying the practice project into workspace/"

if [ ! -d "$WORKSPACE" ]; then
  mkdir -p "$WORKSPACE"
  note "Created workspace/"
fi

# Only copy when workspace/ still holds nothing but its .gitkeep, so that
# running this script twice never overwrites what you have done.
workspace_is_empty=1
while IFS= read -r entry; do
  case "$entry" in
    .gitkeep) ;;
    *) workspace_is_empty=0 ;;
  esac
done < <(ls -A "$WORKSPACE")

if [ "$workspace_is_empty" -eq 1 ]; then
  # The trailing /. copies hidden files too, such as .env and .gemini/.
  cp -a "$VULNERABLE/." "$WORKSPACE/"
  note "Copied the practice project into workspace/"
else
  note "workspace/ already has your work in it, so it was left alone"
fi

# --------------------------------------------------------------- step 5 ----
say "Step 5 of 5: putting a weak Gemini settings file in place"

if [ ! -f "$HOME_SETTINGS_DEST" ]; then
  mkdir -p "$(dirname "$HOME_SETTINGS_DEST")"
  cp "$HOME_SETTINGS_SRC" "$HOME_SETTINGS_DEST"
  note "Created $HOME_SETTINGS_DEST"
  note "It is deliberately weak. Lab 03 is where you fix it."
else
  note "$HOME_SETTINGS_DEST already exists, so it was left alone"
fi

# --------------------------------------------------------------- done -----
say "Ready"

note "Audit tool:  $UPSTREAM_DIR"
note "Audit image: $AUDIT_IMAGE"
note "Your project: $WORKSPACE"
note "Evidence folder: $REPO_ROOT/evidence"
note ""
note "Start with lab-01-introduction/README.md"

echo ""
echo "Setup complete"
