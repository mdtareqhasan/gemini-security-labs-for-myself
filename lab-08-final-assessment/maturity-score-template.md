# Maturity score sheet

Score each of the eight domains from 0 to 4. The weighted score updates as
you go. Nothing is sent anywhere.

**Owner:** <name>

**Date:** <YYYY-MM-DD>

**Scored by:** <name>

## Levels

| Level | Name | What it looks like |
| --- | --- | --- |
| 0 | **Unmanaged** | Personal accounts, no policy, no visibility. |
| 1 | **Aware** | Policy written; approved accounts; developers trained; some user-level settings. |
| 2 | **Managed** | Managed settings enforced across the fleet; sandbox on; MCP and plugin allowlists; telemetry on. |
| 3 | **Monitored** | Detections tested; CI agents separated from privileged jobs; version floor enforced; advisories drive patching. |
| 4 | **Optimised** | Attack tests run automatically in CI; metrics drive policy; agent identities fully scoped; production access denied by default and proven. |

A sensible first target for most organisations is level 2 everywhere, and
level 3 for policy enforcement, isolation and CI/CD, because those three
domains carry most of the critical risks.

## Score

Pick one level per domain and write the evidence that supports it.

| Domain | Weight | Evidence to collect | Level |
| --- | --- | --- | --- |
| **Governance** | 10% | Policy, owners, framework mapping | 0 1 2 3 4 |
| **Identity and access** | 15% | SSO and SCIM setup, login enforcement, CI identity | 0 1 2 3 4 |
| **Policy enforcement** | 20% | Admin controls, machine-wide settings and policy files, audit reports | 0 1 2 3 4 |
| **Isolation (sandbox, containers)** | 15% | Sandbox settings, phase 4 test results | 0 1 2 3 4 |
| **Supply chain (MCP, plugins, actions, packages)** | 10% | Allowlists, pinning, intake records | 0 1 2 3 4 |
| **CI/CD and production** | 15% | Workflow review, branch protection, production access review | 0 1 2 3 4 |
| **Observability and response** | 10% | Telemetry proof, detections, tabletop | 0 1 2 3 4 |
| **Threat intelligence and testing** | 5% | Advisory tracking, test runs | 0 1 2 3 4 |

## Evidence per domain

| Domain | Level | Why this level | Evidence that proves it |
| --- | --- | --- | --- |
| Governance | | | |
| Identity and access | | | |
| Policy enforcement | | | |
| Isolation (sandbox, containers) | | | |
| Supply chain (MCP, plugins, actions, packages) | | | |
| CI/CD and production | | | |
| Observability and response | | | |
| Threat intelligence and testing | | | |

## Weighted score

Weighted score = sum of (level / 4 x weight), out of 4.

| Domain | Weight | Level | Weighted |
| --- | --- | --- | --- |
| Governance | 10% | | |
| Identity and access | 15% | | |
| Policy enforcement | 20% | | |
| Isolation (sandbox, containers) | 15% | | |
| Supply chain (MCP, plugins, actions, packages) | 10% | | |
| CI/CD and production | 15% | | |
| Observability and response | 10% | | |
| Threat intelligence and testing | 5% | | |
| **Total** | **100%** | | **0.0 of 4** |

**Result:** <Unmanaged / Aware / Managed / Monitored / Optimised>

## Compared with last quarter

| Domain | Last quarter | This quarter | Change |
| --- | --- | --- | --- |
| Governance | | | |
| Identity and access | | | |
| Policy enforcement | | | |
| Isolation (sandbox, containers) | | | |
| Supply chain (MCP, plugins, actions, packages) | | | |
| CI/CD and production | | | |
| Observability and response | | | |
| Threat intelligence and testing | | | |
| **Weighted score** | | | |
