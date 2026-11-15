# Lab 03: Execution controls

**Required time:** 45 minutes

**Problem:** Gemini runs commands and edits files with your permissions, so
you need to control what it may run, when it may run it, and where it runs.

## Concept

Three settings do most of the work:

- **Sandbox** (`tools.sandbox`) runs tools inside a sandbox instead of with
  your full user permissions. It is off by default.
- **Approvals** (`general.defaultApprovalMode`) decide when the agent stops
  and asks. `auto_edit` approves every edit.
- **Allowlists** (`tools.allowed`) list tools that skip the confirmation
  dialog entirely, so they must stay read-only.

Folder trust and `disableYoloMode` decide whether a repository, an alias or a
flag can switch those protections off behind your back.

## Hands-on

1. From the repository root, save an audit report as this lab's before
   snapshot:

   ```bash
   mkdir -p evidence/lab-03/before
   cd workspace
   bash "$HOME/coding-agent-security/gemini/audit/run.sh" \
     --report txt --report-dir ../evidence/lab-03/before
   cd ..
   ```

   A vulnerable-project FAIL exit code is expected; continue to inspect the
   report.
2. Compare `workspace/.gemini/settings.json` with `baseline-settings.json`.
   Identify which settings enable the sandbox, keep network access off,
   require confirmation by default, restrict `tools.allowed` to read-only
   commands, and prevent YOLO mode or permanent approvals.
3. If setup created the weak home settings file on this disposable VM, check
   that it still exactly matches the seeded file before replacing it:

   ```bash
   cmp -s "$HOME/.gemini/settings.json" \
     setup-assets/gemini-home-settings.json
   ```

   ```bash
   if cmp -s "$HOME/.gemini/settings.json" \
       setup-assets/gemini-home-settings.json; then
     backup="$HOME/.gemini/settings.json.lab03-backup-$(date +%Y%m%d%H%M%S)"
     cp "$HOME/.gemini/settings.json" "$backup"
     cp lab-03-execution-controls/baseline-settings.json \
       "$HOME/.gemini/settings.json"
     echo "Saved the original settings to $backup"
   else
     echo "Home settings differ from the setup seed; leave them unchanged."
   fi
   ```

   If the files differ, review and merge the baseline manually, or perform
   the exercise in a disposable OS account. Keep any backup outside the
   repository.
4. If the workspace settings still match the original practice-project
   settings, replace them with the baseline:

   ```bash
   if cmp -s workspace/.gemini/settings.json \
       vulnerable-project/.gemini/settings.json; then
     cp lab-03-execution-controls/baseline-settings.json \
       workspace/.gemini/settings.json
   else
     echo "Workspace settings changed; merge the baseline manually."
   fi
   ```

   If you have changed that file already, compare and merge the settings
   instead of overwriting your work. If the home settings were not seeded
   by setup, user-level audit findings may remain; record that rather than
   replacing an existing configuration.
5. Read `baseline.toml`. It denies dangerous shell prefixes and asks before
   network or publishing commands. Install it as a separate user policy,
   preserving any existing policies:

   ```bash
   mkdir -p "$HOME/.gemini/policies"
   cp -n lab-03-execution-controls/baseline.toml \
     "$HOME/.gemini/policies/gemini-security-labs-baseline.toml"
   ```

   If that destination already exists, inspect it and merge manually; do not
   overwrite it. Policy behavior is version-dependent, so verify the
   installed Gemini CLI documentation and never rely on a rule without
   testing it in a disposable environment.
6. Save the after snapshot in a separate directory and compare the findings:

   ```bash
   mkdir -p evidence/lab-03/after
   cd workspace
   bash "$HOME/coding-agent-security/gemini/audit/run.sh" \
     --report txt --report-dir ../evidence/lab-03/after
   cd ..
   ```

   A FAIL may remain for an unmodified or unavailable control. Explain those
   findings instead of claiming the baseline fixed them.

## Evidence

Put the before-and-after reports, a short explanation of your settings
choices, and any screenshots in `evidence/lab-03/`. Review reports for
sensitive data before committing.

## Push

```bash
git add evidence/lab-03
git commit -m "lab 03: execution controls"
git push
```
