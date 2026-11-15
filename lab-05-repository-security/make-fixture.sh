#!/usr/bin/env bash
#
# Lab 05: create the two things a normal `git clone` never gives you.
#
#   1. a .git/config key that makes git run a program
#   2. a symlink that points outside the project
#
# Both are created inside workspace/, at run time. They are never committed.
#
# Usage:
#   bash lab-05-repository-security/make-fixture.sh

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORKSPACE="$REPO_ROOT/workspace"
OUTSIDE_FILE="$HOME/gemini-labs-outside-target.txt"
OUTSIDE_LINK="$WORKSPACE/shared-notes.txt"

say() {
  echo ""
  echo "==> $*"
}

note() {
  echo "    $*"
}

if [ ! -d "$WORKSPACE" ]; then
  echo "ERROR: $WORKSPACE does not exist. Run setup.sh first." >&2
  exit 1
fi

say "Creating the Lab 05 fixture inside workspace/"

# ------------------------------------------------------- 1. .git/config ----
GIT_DIR="$WORKSPACE/.git"
GIT_CONFIG="$GIT_DIR/config"

mkdir -p "$GIT_DIR"

if [ -f "$GIT_CONFIG" ]; then
  note "A .git/config already exists, adding to it"
else
  note "Creating $GIT_CONFIG"
fi

cat >> "$GIT_CONFIG" <<'EOF'

# Added by lab-05-repository-security/make-fixture.sh
# A repository that arrives with its own .git/config can make git run a
# program during ordinary commands such as "git status". The command below is
# a harmless echo, but the key is exactly what an attacker would use.
[core]
	fsmonitor = echo "gemini-security-labs: a program would run here"
EOF

note "Added a 'core.fsmonitor' key that would run a program"
note "It runs 'echo', so nothing happens. A real attack would not be kind."

# ------------------------------------------------------- 2. symlink --------
say "Creating a symlink that points outside the project"

if [ ! -f "$OUTSIDE_FILE" ]; then
  cat > "$OUTSIDE_FILE" <<'EOF'
This file lives outside the gemini-security-labs project.
It holds nothing but this text.
EOF
  note "Created $OUTSIDE_FILE (a harmless file outside the project)"
else
  note "$OUTSIDE_FILE already exists, using it as it is"
fi

if [ -L "$OUTSIDE_LINK" ] || [ -e "$OUTSIDE_LINK" ]; then
  rm -f "$OUTSIDE_LINK"
fi

ln -s "$OUTSIDE_FILE" "$OUTSIDE_LINK"

if [ -L "$OUTSIDE_LINK" ]; then
  note "Created $OUTSIDE_LINK -> $(readlink "$OUTSIDE_LINK")"
else
  note "WARNING: this filesystem did not create a real symlink."
  note "          Run this lab on Linux so the symlink check can see it."
fi

# ------------------------------------------------------- report ------------
say "What was created"

cat <<EOF
    $GIT_CONFIG
        a 'core.fsmonitor' key that makes git run a program

    $OUTSIDE_LINK
        a symlink pointing outside the project

    $OUTSIDE_FILE
        the harmless file the symlink points at
EOF

say "Next step"

note "Run the audit from inside workspace/ and look for:"
note "  P14  .git/config makes git run programs"
note "  P13  Symlinks point outside the project"
note ""
note "Do not commit these files. The repo's .gitignore already skips them."
