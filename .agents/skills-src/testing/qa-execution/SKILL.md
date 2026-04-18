---
name: qa-execution
description: >
  Executes test plans, verifies implementation against acceptance criteria, and produces structured bug reports.
  Do NOT use for designing test scenarios (use qa-design).
version: "1.1.0"
time_saved: "Manual: 1-3h | With skill: 15-30m"
license: Proprietary — Personal Use Only
category: testing
complexity: Intermediate
tokens: ~2500
tags: [qa, test-execution, bug-report, verification, acceptance-criteria, regression]
author: vheins
---

# Skill: QA Execution

## Purpose
Execute language-agnostic test plans against implementations to produce pass/fail verification reports and reproduction evidence.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `feature_description` | string | Yes | Feature purpose |
| `test_plan` | string | Yes | Scenarios to run |
| `implementation_summary` | string | Yes | Endpoints/components |
| `tech_stack` | string | No | Technology stack |
| `environment` | string | No | Test env details |

## Instructions
- **Checks**: Verify clean/seeded env, running deps, and AC coverage before starting.
- **Automation**: Execute test commands (e.g., `pest`, `jest`, `pytest`); report PASS/FAIL/SKIP with reasons.
- **Manual**: Follow plan steps exactly; verify expected vs. actual UI/logic behavior.
- **Side-Effects**: Confirm DB records (created/updated/deleted) and event emissions.
- **Bug Reporting**: For every FAIL, provide Bug ID, Severity, Actual vs Expected, Steps, and Evidence.
- **Verdict**: Compile summary table and provide final verdict: PASS, FAIL, or BLOCKED.

## Edge Cases
| Case | Strategy |
|------|----------|
| Flaky | Document as flaky; do not confirm bug until consistently reproducible. |
| Environment | Explicitly document environment-specific discrepancies. |
| Blocked | Mark as BLOCKED with clear reason; do not skip silently. |

## Workflow
```mermaid
flowchart TD
    A([Start: QA Execution]) --> B[Parse inputs]
    B --> C[Pre-Execution Checklist]
    C --> D{Blockers?}
    D -- Yes --> E[Document blockers, mark BLOCKED]
    D -- No --> F
    E & F --> G[For each scenario]
    G --> H{Automatable?}
    H -- Yes --> I[Automated Execution]
    H -- No --> J[Manual Verification]
    I & J --> K[State/Side-Effect Verification]
    K --> L{Result?}
    L -- PASS --> M[Mark PASS]
    L -- FAIL --> N[Write Bug Report]
    L -- SKIP --> O[Document skip reason]
    M & N & O --> P{More scenarios?}
    P -- Yes --> G
    P -- No --> Q[Compile Summary Table]
    Q --> R[Regression Check]
    R --> S{Any FAILs?}
    S -- Yes --> T[Final Verdict: FAIL]
    S -- No --> U{Any BLOCKEDs?}
    U -- Yes --> V[Final Verdict: BLOCKED]
    U -- No --> W[Final Verdict: PASS]
    T & V & W --> X([Output: Report])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Bug reports reproducible.
- [ ] Severity accurate.
- [ ] Actual vs Expected clear.
- [ ] Environment info captured.
- [ ] Regression risks identified.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.0.0 | 2026-03-20 | Initial release |
