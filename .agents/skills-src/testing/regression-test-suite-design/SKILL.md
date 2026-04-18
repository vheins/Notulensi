---
name: regression-test-suite-design
description: >
  Designs a regression test suite covering critical paths, bug fixes, and high-risk areas. Do NOT use for new feature or performance testing.
version: "1.1.0"
time_saved: "15-20 minutes"
license: Proprietary — Personal Use Only
category: testing
complexity: Intermediate
tokens: ~8500
tags: [regression-testing, test-suite, bug-prevention, critical-paths]
author: vheins
---

# Skill: Regression Test Suite Design

## Purpose
Design a prioritized test catalog preventing bug recurrence and ensuring critical functional persistence.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `application_description`| string | Yes | App features and history |
| `tech_stack` | string | Yes | Stack and framework |
| `bug_history` | string | No | List of previously fixed bugs |

## Instructions
- **Critical Paths**: Identify core user journeys, revenue-critical features, auth flows, and integrations.
- **Prioritization**: Assign levels P0 (Smoke), P1 (Critical), P2 (High), P3 (Medium), or P4 (Low).
- **Bug Fixes**: Create unique tests per known bug (named BUG-{ID}) to verify fixes.
- **High-Risk**: Focus on complex logic, data transformations, and concurrent state management.
- **Efficiency**: Group by feature; identify parallel tests to minimize execution time.
- **Data**: Define scenarios for production-like volumes, migration states, and edge cases.

## Edge Cases
| Case | Strategy |
|------|----------|
| Flaky | Analyze for non-determinism; fix or remove from suite. |
| Dependency | Ensure test independence from shared or production data. |
| Performance | Include specific timing assertions for P0/P1 paths. |

## Workflow
```mermaid
flowchart TD
    A([Start]) --> B[Parse inputs]
    B --> C[Identify Critical Paths]
    C --> D[Prioritize Tests P0-P4]
    D --> E{Bug history?}
    E -- Yes --> F[Create bug regression tests]
    E -- No --> G[Focus on high-risk areas]
    F & G --> H[Cover High-Risk Areas]
    H --> I[Design for Efficiency]
    I --> J[Include Data Scenarios]
    J --> K[Define Execution Strategy]
    K --> L[Define Parallel Groups]
    L --> M([Output: Design + Code])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Critical paths covered in P0/P1.
- [ ] Known bugs have regression tests.
- [ ] Prioritized by risk level.
- [ ] Execution set is efficient (parallelizable).
- [ ] Tests are self-contained.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples/references, added fields |
| 1.0.0 | 2026-03-20 | Initial release |
