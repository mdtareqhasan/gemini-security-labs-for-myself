# Lab 07: Security assessment

**Required time:** 40 minutes

**Problem:** The audit can only read files, so the parts of your setup that
live outside files have to be checked by a person, and every place Gemini
runs needs a blast radius and a plan for the day it goes wrong.

## Concept

An assessment answers one question for every place Gemini runs: **if injected
text hijacked the agent right now, what could it reach, and would you know?**

- The **audit** covers what is written in files.
- The **manual checklist** covers the six items no tool can see: licences,
  admin controls, workflow secrets and working habits.
- A **threat model** turns a place Gemini runs into a list of identities,
  credentials, data, reachable systems, attack surface and impact.
- An **incident runbook** says what to do in the first hour: detect, contain,
  rotate credentials, report, learn.

## Hands-on

1. Complete `manual-checklist.md`. For every item, write the date and how
   you verified it; leave a box unchecked if you cannot produce evidence.
   Do not infer cloud-admin settings from a local audit.
2. Make a separate copy of `threat-model-template.md` for each place Gemini
   runs (for example, a developer VM and a CI runner). Describe reachable
   credentials and systems without recording secret values.
3. Fill in `incident-runbook-template.md` with real team contacts, alert
   locations, credential owners and escalation steps. If this is a practice
   environment, use role placeholders and clearly mark them as such.
4. Hold a short tabletop: pretend an issue caused an agent to post
   unauthorized content. Walk through detection, stopping the workflow,
   preserving logs, rotating any exposed credentials, notifying owners and
   scheduling a re-test. Do not actually trigger an agent or rotate
   production credentials.
5. Add each gap to the risk register in Lab 08, with an owner and due date.

## Evidence

Save completed checklists, threat models, the runbook and tabletop notes in
`evidence/lab-07/`. Remove real names, contact details, account identifiers
and secret values before committing.

## Push

```bash
git add evidence/lab-07
git commit -m "lab 07: security assessment"
git push
```
