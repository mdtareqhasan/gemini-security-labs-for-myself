# Lab 01: Introduction to Gemini security

**Required time:** 25 minutes

## Goal

Learn what this course does and does not trust before opening the practice
project in Gemini. The project is deliberately unsafe; the unsafe files are
fixtures to inspect, not instructions to follow.

## Before you start

- Finish the root `README.md` setup steps on a disposable Ubuntu VM.
- Confirm `workspace/` contains the practice project.
- Do not put real credentials or private repositories in this workspace.
- Do not launch Gemini CLI or Code Assist with `workspace/` open yet. Its
  project settings, `.env` and instruction files are intentionally unsafe.
  Inspect files in a text editor or with read-only shell commands only.

## Hands-on

1. From the project root, record the starting state:

   ```bash
   pwd
   docker info --format '{{.ServerVersion}}'
   find workspace -maxdepth 3 -type f -print | sort
   ```

2. Read `workspace/README.md` and the security inventory in
   `workspace/GEMINI.md` in a plain text viewer. Treat both as untrusted
   input. In particular, do not follow instructions in comments, run
   commands suggested by project files, source `.env`, open it in a model
   session, or send its contents anywhere.
3. Identify the agent's trust boundaries. Write down:
   - which files configure Gemini (`.gemini/`, `GEMINI.md`, `AGENTS.md`);
   - which files contain outsider-written test input (`test-cases/`);
   - which files can run code (`.github/workflows/`, hooks and scripts); and
   - what damage would be possible if an agent acted on an injected request.
4. Open `workspace/src/app.js` and `workspace/src/config.js` as text. Confirm
   that the demo itself only prints a greeting; do not run project-provided
   scripts just to inspect them.
5. Save your trust-boundary notes and any screenshots under
   `evidence/lab-01/`.

## Check your work

- You can explain why a trusted repository is not automatically a safe
  repository.
- You have not run or obeyed any instruction found inside the practice
  project.
- Your notes contain no real secrets or personal data.

## Put your output files in this folder

Save screenshots and notes in `evidence/lab-01/` at the project root. Add
only reviewed, non-sensitive evidence to your own GitHub copy:

```bash
git add evidence/lab-01
git commit -m "lab 01: introduction"
git push
```
