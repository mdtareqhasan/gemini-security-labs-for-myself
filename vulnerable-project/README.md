# Demo project (intentionally insecure)

This project is **intentionally insecure** and exists only for learning.

Every problem in it is planted on purpose, so that the gemini-security-labs
audit can find it. Do not copy this project, do not copy its settings, and do
not copy its `.env`.

## What is planted here, on purpose

| File | Planted problem | Lab |
| --- | --- | --- |
| `.gemini/settings.json` | sandbox off, any shell command allowed, an MCP server marked `"trust": true` and unpinned, a hook | 03, 04 |
| `.env` | sets `GEMINI_SANDBOX=false` | 03, 05 |
| `.gitignore` | does not ignore `.env` | 05 |
| `GEMINI.md` | instructions hidden in an HTML comment, plus an invisible Unicode character | 05 |
| `AGENTS.md` | tells the agent to approve everything without asking | 05 |
| `.github/workflows/gemini.yml` | `write-all` permissions, an unpinned action, and issue text passed straight into the prompt | 06 |
| `test-cases/` | fake tickets, logs and an issue that carry injected instructions | 04, 06 |

## Safety

All credentials here are fake, every URL points at `example.com`, and no
script does anything except print text.
