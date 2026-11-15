# Final report

A short report for people who will not read the audit output. Keep it to one
or two pages. Fill in the bracketed parts and delete the guidance lines.

**Prepared by:** <name>

**Date:** <YYYY-MM-DD>

**Scope:** <which machines, projects and workflows you assessed>

## 1. In one paragraph

<What you assessed, what you found, and what the current exposure is. Three
or four sentences. No jargon.>

## 2. What we found

| Area | Result | Severity | What happened |
| --- | --- | --- | --- |
| Sandbox, trust and approvals | <FAIL/WARN/PASS count> | | |
| Policies and hooks | | | |
| Extensions and MCP servers | | | |
| Repositories | | | |
| CI/CD | | | |
| Manual checks | | | |

Total: **<n> FAIL, <n> WARN, <n> PASS, <n> INFO**

## 3. What we fixed

| # | Finding | Fix | Verified by | Date |
| --- | --- | --- | --- | --- |
| 1 | | | | |
| 2 | | | | |
| 3 | | | | |

## 4. What is still open

| ID | Risk | Severity | Owner | Due date |
| --- | --- | --- | --- | --- |
| R-01 | | | | |
| R-02 | | | | |
| R-03 | | | | |

<One sentence on why these are not done, and what happens if they are not
done by the due date.>

## 5. Our score

| Domain | Level |
| --- | --- |
| Governance | |
| Identity and access | |
| Policy enforcement | |
| Isolation (sandbox, containers) | |
| Supply chain (MCP, plugins, actions, packages) | |
| CI/CD and production | |
| Observability and response | |
| Threat intelligence and testing | |

**Weighted score: <n.n> of 4 — <level>**

## 6. Evidence

List the files you are keeping as the record of this assessment.

- Audit report: <file name>
- Manual checklist: <file name>
- Threat models: <file names>
- Incident runbook: <file name>
- Risk register: <file name>

## 7. Next review

**Date:** <YYYY-MM-DD>

<What triggers an earlier review: a Gemini CLI upgrade, a new MCP server, a
new workflow, an incident.>
