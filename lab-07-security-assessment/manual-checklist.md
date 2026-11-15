# Manual checklist

The audit reads files. These six checks live outside files, so a person has
to confirm them. Work through them, tick the box, and keep the result with
your audit report as your assessment record.

A tick means you **checked it yourself**, not that someone told you it was
fine. Write the date and how you checked it in the Notes column.

## A. Installation and identity

| # | Check | Priority | Confirmed | Notes |
| --- | --- | --- | --- | --- |
| A2 | Work runs under your organisation's Code Assist Standard or Enterprise licence, so its admin controls apply. | P1 | [ ] | |

## F. GitHub Actions

| # | Check | Priority | Confirmed | Notes |
| --- | --- | --- | --- | --- |
| F3 | Workflows hold only the permissions and secrets they need. | P1 | [ ] | |

## G. Working habits

| # | Check | Priority | Confirmed | Notes |
| --- | --- | --- | --- | --- |
| G1 | Instruction-like text in issues, pull requests, READMEs and web pages is read by a person before Gemini acts on it. | P1 | [ ] | |
| G2 | Changes to `.gemini/`, `GEMINI.md` and workflows are treated as security events. | P1 | [ ] | |
| G3 | No production credentials in the environment Gemini runs in. | P1 | [ ] | |
| G4 | Suspicious agent behaviour is reported to the security team the same day. | P2 | [ ] | |

## Notes

Write down what you found, who owns each item and when it will be closed.
