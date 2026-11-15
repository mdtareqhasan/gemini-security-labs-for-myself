# Incident runbook: <the agent leaked something>

One page for the whole team. Keep it short enough that the person on call
reads it in the first minute. Print it, or keep it where the on-call rota
points to it.

**Owner:** <name>

**Last tested:** <YYYY-MM-DD, tabletop or live>

**Applies to:** a leaked key, an injected agent action, a malicious MCP server
or extension, and a compromised workflow.

## 1. Detect

- What did you see? <the alert, log line, comment, or report>
- Which agent and which place? <laptop / CI runner / server>
- When did it happen, and when did you notice? <both times>
- What might have been reached? <key, file, system>

**Where to look:** <list the logs and dashboards that answer these questions>

## 2. Contain

Do these in order, before anything else.

- [ ] Stop the agent. <stop the job, close the session, disable the workflow>
- [ ] Revoke the session and the trust you gave the folder.
- [ ] Remove or disable the trigger: <hook, MCP server, extension, workflow>
- [ ] Preserve the evidence: <what to copy, and where to put it>
- [ ] Do not delete the repository or the logs. Do not wipe the machine.

## 3. Rotate credentials

- [ ] List every credential the agent could reach (use the threat model).
- [ ] Rotate each one: <API keys, tokens, SSH keys, cloud roles>
- [ ] Update the consumers: <CI, services, local dev setups>
- [ ] Check the old credential's usage log, from the moment of exposure on.

## 4. Report

- [ ] Tell the security team the same day. <name, channel, ticket link>
- [ ] Write down: what happened, when, what was reached, what you did.
- [ ] Tell the people who own the affected systems. <who>
- [ ] Tell the data owner if data was involved. <who>

## 5. Learn

- [ ] What let it through? <missing control, unchecked file, bad habit>
- [ ] Add the check to the manual checklist or the audit.
- [ ] Update this runbook with what surprised you.
- [ ] Set a date to re-test this scenario.

## Escalation

| When | Who |
| --- | --- |
| A credential reached production | <name, phone> |
| Personal or regulated data involved | <name, phone> |
| Public disclosure or an active leak | <name, phone> |
