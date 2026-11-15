# Lab 08: Final assessment

**Required time:** 60 minutes

**Problem:** Findings on their own are a list. The point of the final
assessment is to turn that list into a scored picture of where you stand, a
register of what to fix first, and a short report someone can act on.

## Concept

- A **risk register** gives every finding an ID, a severity, the evidence
  behind it, the fix and an owner, so nothing is lost.
- The **maturity model** scores eight weighted domains from 0 to 4, so you
  can show progress over time and re-run it every quarter.
- The **final report** pulls it together for people who will not read the
  audit output: what is the exposure, what you fixed, what is left, and by
  when.

Score with evidence. A domain you cannot evidence is a 1, not a 3.

## Hands-on

1. Copy `risk-register-template.md` into your evidence folder. Add one row
   per unresolved audit or manual-checklist finding. Link each row to
   sanitized evidence, an owner, a concrete fix and a due date. Mark a
   finding Fixed only after a re-check confirms the fix.
2. Score each domain in `maturity-score-template.md` from 0 to 4 using the
   stated evidence. A domain without evidence must not score above 1. For
   each domain calculate `level / 4 * weight`; the weights sum to 100%, so
   the weighted total is out of 4. Record the evidence, not just the score.
3. Use the risk register and score sheet to complete
   `final-report-template.md`. State the scope, exposure, completed fixes,
   open risks, owners, due dates and next review date. Keep the report
   concise and free of secret values.
4. Have a second person check that every open risk has an owner and due
   date, every claimed fix has verification evidence, the weighted score
   matches the domain scores, and the report agrees with the audit.
5. Schedule a quarterly re-assessment and an earlier review after a Gemini
   upgrade, new MCP server or extension, workflow change, or incident.

## Evidence

Put the completed register, score sheet, final report and review notes in
`evidence/lab-08/`. Sanitize evidence before committing; do not publish
credentials, private machine details or sensitive audit data.

## Push

This is the last course push:

```bash
git add evidence/lab-08
git commit -m "lab 08: final assessment"
git push
```
