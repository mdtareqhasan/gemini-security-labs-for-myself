# gemini-security-labs

Hands-on labs for securing **Gemini CLI** and **Gemini Code Assist**.

Eight short labs. Each lab runs on a fresh machine, so you can redo one lab
without breaking the last one.

## What you need

- Ubuntu (the Poridhi VM works well)
- Docker, installed and running
- `git` and `bash`
- A GitHub account

## How to use this repo

1. On GitHub, click **Use this template** to get your own private copy.
2. Clone your copy to your machine:

   ```bash
   git clone https://github.com/<your-name>/gemini-security-labs.git
   cd gemini-security-labs
   ```

3. Run the setup script:

   ```bash
   bash setup.sh
   ```

   It clones the audit tool, copies the practice project into `workspace/`
   and puts a deliberately weak settings file in `~/.gemini/`. Run it as many
   times as you like: it never overwrites your work.

4. Open the folder for the lab you are on and follow its README.

## The folders

| Folder | What it is |
| --- | --- |
| `workspace/` | Your working copy of the practice project. Change it freely. |
| `vulnerable-project/` | The practice project as it ships. Do not edit it. |
| `evidence/` | Screenshots, reports and notes you collect during the labs. |
| `setup-assets/` | Files `setup.sh` copies into your home folder. |
| `lab-01-...` to `lab-08-...` | One folder per lab, with its instructions. |

## After every lab

Save reviewed work and push it to your own copy. Stage only the paths you
intend to publish; do not use `git add -A` without checking what it includes.

```bash
git add evidence/lab-03/
git commit -m "lab 03: execution controls"
git push
```

## Safety

The practice-project credentials are placeholders and its example URLs use
`example.com`. The repository does contain scripts that make changes:
`setup.sh` clones the audit tool, builds a Docker image, copies files and may
create a Gemini settings file; Lab 05's fixture script writes test files and
creates a symlink. Read each script before running it, and use a disposable
VM with no real credentials.

The audit itself runs in a throwaway container that is offline, read-only,
and deleted when it finishes. It still reads the project and applicable
Gemini settings, so run it only against the practice workspace and review
reports before sharing them.

## Licence

These labs are yours to use and change. The audit tool they use comes from
[AISecurityLabs.org](https://github.com/aisecuritylabs-org/coding-agent-security)
and is MIT licensed. `setup.sh` clones it for you rather than copying it here.
