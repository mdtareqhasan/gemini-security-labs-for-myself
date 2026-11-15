# Lab 05: Repository security

**Required time:** 45 minutes

**Problem:** A repository can configure the agent, ship its own secrets and
hide instructions from you, so you have to review what a project asks Gemini
to read before you trust it.

## Concept

- A trusted folder's `.gemini/settings.json` **overrides your own settings**,
  so a repository can turn your sandbox off or allow tools for everyone.
- A trusted folder's `.env` is loaded into Gemini's environment, and
  `GEMINI_SANDBOX=false` there turns the sandbox off.
- `GEMINI.md` and `AGENTS.md` are loaded as **instructions**. An HTML comment
  or a zero-width character can hide an instruction from you while the model
  still reads it.
- `.gitignore` must cover `.env`, or one "commit everything" publishes your
  keys.
- A repository that arrives with its own `.git/config`, or with symlinks, is
  not a normal clone. Git settings such as `core.fsmonitor` run programs
  during ordinary git commands.

## Hands-on

1. Review `workspace/.gitignore`, `.env`, `.gemini/settings.json`,
   `GEMINI.md` and `AGENTS.md` as text. Do not source `.env`, obey hidden
   instructions, or accept settings just because they are in a trusted
   folder. Record which controls each file could weaken.
2. From the repository root, create the lab fixture:

   ```bash
   bash lab-05-repository-security/make-fixture.sh
   ```

   It writes a harmless `core.fsmonitor` command to `workspace/.git/config`,
   creates `workspace/shared-notes.txt` as a symlink, and creates the
   symlink's harmless target at `~/gemini-labs-outside-target.txt`.
3. **Do not run `git` commands from inside `workspace/` after creating the
   fixture.** Git may run the configured `core.fsmonitor` program. The
   fixture command only prints text, but treat the setting as executable.
4. Run the audit from the repository root, targeting the workspace:

   ```bash
   cd workspace
   bash "$HOME/coding-agent-security/gemini/audit/run.sh" --no-report
   ```

   The audit is read-only and offline. Look for P08-P10 and P12-P14 and note
   which files or paths support each result. Return to the repository root
   with `cd ..` only after the audit exits.
5. In your notes, list the evidence a human review or clone process should
   require before trusting a project. Do not commit the generated `.git/`
   fixture.

## Evidence

Save the finding IDs, sanitized notes, and screenshots in
`evidence/lab-05/`. Do not include `.git/config`, real environment values, or
the generated symlink fixture.

## Push

```bash
git add evidence/lab-05
git commit -m "lab 05: repository security"
git push
```
