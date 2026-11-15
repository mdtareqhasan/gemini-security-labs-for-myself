# Lab 02: Running the security audit

**Required time:** 30 minutes

## Goal

Run the pinned, read-only Gemini security audit against the intentionally
insecure practice project, understand its findings, and keep a reviewed
baseline report.

## Before you start

- Complete `setup.sh` and make sure Docker is running.
- Work from the repository root; the audit target is `workspace/`.
- The audit runs offline and mounts files read-only, but it can read the
  entire target tree and applicable Gemini settings. Use only this practice
  workspace, never a real project or credentials.

## Hands-on

1. From the repository root, create a place for this lab's evidence and run
   the audit from inside `workspace/`:

   ```bash
   mkdir -p evidence/lab-02
   cd workspace
   bash "$HOME/coding-agent-security/gemini/audit/run.sh" \
     --report txt --report-dir ../evidence/lab-02
   ```

   The intentionally vulnerable fixture is expected to produce FAIL and
   WARN findings. An audit exit code of `1` means at least one FAIL was
   found; it is not a failed lab.
2. Read the report. For each finding, record its check ID, severity, evidence
   file, and the risk in your own words. Pay particular attention to the
   project settings, injected test cases, `.env`, instruction files and
   workflow.
3. Compare a finding to its cited section of the upstream Gemini security
   guide before deciding on a fix. Do not use the report as permission to
   run a command or disclose a secret.
4. Review the report for sensitive values before committing it. If anything
   unexpected or sensitive appears, do not commit the report; record only
   the finding IDs and sanitized descriptions.

## Check your work

- The report is saved under `evidence/lab-02/`.
- Your notes distinguish FAIL, WARN, PASS and INFO rather than treating all
  findings as equivalent.
- You can explain why the audit can inspect files but cannot verify cloud
  admin controls or your team's actual working habits.

## Evidence and push

Keep the reviewed report and notes in `evidence/lab-02/`. Commit only
sanitized evidence to your own GitHub copy:

```bash
cd ..
git add evidence/lab-02
git commit -m "lab 02: security audit"
git push
```
