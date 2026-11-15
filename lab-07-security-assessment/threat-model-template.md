# Threat model: <place Gemini runs>

One copy of this page for every place Gemini runs: your laptop, a container,
a CI runner, a shared build box. Copy the file, rename it, fill it in.

**Place:** <for example "developer laptop, poridhian's Poridhi VM">

**Owner:** <name>

**Date:** <YYYY-MM-DD>

**Question this page answers:** if injected text hijacked the agent right now,
what could it reach, and would we know?

## Identity

- Who runs the agent here? <user, service account, runner identity>
- What role does it have? <for example "developer on the payments team">
- Which licence applies? <Code Assist Standard / Enterprise / n-a>
- Is it a person, a job, or both?

## Credentials

- What can this agent read? <API keys, tokens, SSH keys, cloud credentials>
- Where do they come from? <environment variables, .env file, secret store>
- Are they long-lived? <yes / no, rotated how often>
- Could a prompt injection reach them? <yes / no, why>

## Data

- What data does this agent work on? <source code, tickets, logs, customer data>
- What is the most sensitive thing in reach? <name it>
- Is any of it personal or regulated data? <yes / no, which>

## Accessible systems

- What can this agent reach? <repositories, CI, cloud accounts, databases>
- Which of those are production? <list them>
- What is the read path and what is the write path? <describe both>

## Attack surface

- What text does the agent read that someone else wrote? <issues, PRs, tickets, READMEs, web pages>
- Which of those are trusted and which are not? <be explicit>
- What runs automatically? <hooks, workflows, MCP servers, extensions>
- What is unpinned or unreviewed? <list it>

## Impact

- If this agent is hijacked today, what is the worst outcome? <one paragraph>
- Does it reach production? <yes / no>
- Would we notice? <which log, which alert, or "nothing today">
- How fast would we notice? <minutes / hours / days>

## Next steps

| # | Gap | Owner | Due date |
| --- | --- | --- | --- |
| 1 | | | |
