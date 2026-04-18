---
name: flaky-test-diagnosis
description: >
  Use to diagnose flaky tests that pass and fail intermittently due to timing issues, state leakage, or external dependencies.
  Do NOT use for fixing functional bugs or writing new tests.
version: "1.1.0"
time_saved: "Manual: 1-3 hours | With skill: 10-15 minutes"
license: Proprietary — Personal Use Only
category: testing
complexity: Intermediate
tokens: ~7000
tags: [flaky-tests, test-reliability, timing-issues, test-isolation]
author: vheins
---

# Skill: Flaky Test Diagnosis

## Purpose
Diagnose root causes of intermittent test failures (flakiness) and provide targeted synchronization or isolation fixes.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `flaky_test_code` | string | Yes | Code and observed errors |
| `tech_stack` | string | Yes | e.g., "Node.js + Jest" |
| `failure_pattern` | string | No | e.g., "fails only in CI" |

## Instructions
- **Category Check**: Analyze for Timing (race, missing await), Shared State (global var, DB leakage), External Deps (network, time), Order Dependency, or Resource Contention (ports, memory).
- **Diagnosis**: Explain the root cause; show problematic code vs. fixed code.
- **Remediation**:
  - Replace `sleep()` with proper async waits.
  - Implement database transaction rollbacks.
  - Mock external services, time, and random numbers.
  - Reset singletons/caches in `beforeEach`.
- **Hardening**: Add a prevention checklist (no shared mutable state, run-in-any-order).
- **Verification**: Ensure tests are self-contained (Arrange/Act/Assert/Cleanup).

## Edge Cases
| Case | Strategy |
|------|----------|
| Network | Always mock external API calls; do not rely on live services. |
| Time | Mock `Date.now()` or `new Date()` to avoid midnight/boundary failures. |
| Parallel | Check for port conflicts or shared resource locks when running in parallel. |

## Workflow
```mermaid
flowchart TD
    A([Start: Flaky Test Diagnosis]) --> B[Parse flaky_test_code
tech_stack, failure_pattern]
    B --> C{failure_pattern
provided?}
    C -- Yes --> D[Use pattern as primary clue:
fails in CI / fails with other tests
fails 1 in 10 / fails at midnight]
    C -- No --> E[Analyze all flakiness categories]
    D & E --> F{Fails only in CI
not locally?}
    F -- Yes --> G[Check: environment differences
OS, timezone, locale
resource contention
port conflicts in parallel runs]
    F -- No --> H
    G & H --> I{Fails when run
with other tests?}
    I -- Yes --> J[Check: shared state
global variables modified
DB not cleaned between tests
cache not reset
singleton shared]
    I -- No --> K
    J & K --> L{Fails intermittently
without pattern?}
    L -- Yes --> M[Check: timing/async issues
race conditions
missing await
arbitrary sleep
timeout too short]
    L -- No --> N
    M & N --> O{Test calls real
external services?}
    O -- Yes --> P[Root cause: external dependency
Mock network calls
Mock time: new Date
Mock random numbers]
    O -- No --> Q
    P & Q --> R[Identify root cause category:
Timing / Shared State / External
Order Dependency / Resource Contention]
    R --> S[Show problematic code
Explain why it causes flakiness]
    R --> T[Provide 2-3 fix options
with code examples
Explain why each fix works]
    T --> U[Write fixed test code
with all issues resolved]
    U --> V[Add prevention checklist:
test isolation verified
no shared mutable state
tests run in any order
tests run in parallel]
    V --> W([Output: Diagnosis Report + Fixed Test Code
Root cause + fixes + prevention])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Root cause correctly identified.
- [ ] Fix addresses root cause, not symptom.
- [ ] Test isolation verified.
- [ ] Fix documented to prevent recurrence.
- [ ] Prevention checklist included.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples to examples/, references to references/, added compatibility and license fields |
| 1.0.0 | 2026-03-20 | Initial release |
