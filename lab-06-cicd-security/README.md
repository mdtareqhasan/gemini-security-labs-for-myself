# Lab 06: CI/CD security

**Required time:** 35 minutes

**Problem:** A CI workflow that runs an AI agent on text someone else wrote
gives that person the workflow's secrets, so the workflow needs pinning,
narrow permissions and a trusted trigger.

## Concept

- `google-github-actions/run-gemini-cli` before 0.1.22 **trusted the
  workspace** in CI (CVE-2026-12537), and it must be pinned by commit SHA.
- Issue, pull request and comment text is **written by outsiders**. Passing
  it straight into the prompt is a prompt injection with the workflow's
  credentials attached.
- Running the agent with `--yolo` removes every confirmation, so a single
  injected instruction is enough.
- `permissions: write-all` hands the job every scope it has. Each job should
  have only the permissions and secrets it needs.
- `CODEOWNERS` should cover `.gemini/`, `GEMINI.md` and the workflows, so a
  change to them is reviewed by a human.

## Hands-on

1. Read `workspace/.github/workflows/gemini.yml` as text. Trace the trigger,
   token permissions, checked-out code, action version, prompt inputs, flags
   and secrets available to the job.
2. Read `workspace/test-cases/github-issue.txt` as untrusted text. Identify
   which lines attempt to change the agent's task. Do not paste the issue
   into a real agent session or execute its instructions.
3. Write down the minimum changes needed to remove the risks:
   - pin each third-party action to a reviewed full commit SHA (a mutable
     branch or tag is not an immutable pin);
   - grant only the permissions the job needs, at job scope;
   - do not expose write tokens or secrets to a job that processes outsider
     text;
   - do not use `--yolo` or treat prompt wording as a security boundary; and
   - require human review before publishing an agent-generated response.
4. Design and document a safer workflow for this use case. Prefer a
   permissionless analysis step that produces an untrusted draft, followed
   by a human-reviewed publishing step with narrowly scoped write access.
   If that separation is not possible, do not run the agent on outsider
   input. Include `CODEOWNERS` coverage for `.gemini/`, `GEMINI.md` and
   workflow files in your design.
5. Compare your design with the planted workflow and note what the audit
   checks. Keep the intentionally vulnerable fixture unchanged; do not
   enable or run its workflow.

## Evidence

Put your threat analysis, proposed controls, audit finding IDs and sanitized
screenshots in `evidence/lab-06/`. Do not include tokens, secrets, or
unreviewed agent output.

## Push

```bash
git add evidence/lab-06
git commit -m "lab 06: cicd security"
git push
```
