---
name: smoke-test-suite
description: >
  Generates a smoke test suite for post-deployment verification of critical system functionality.
  Do NOT use for comprehensive regression or performance testing.
version: "1.1.0"
time_saved: "Manual: 2-3h | With skill: 10-15m"
license: Proprietary — Personal Use Only
category: testing
complexity: Beginner
tokens: ~2000
tags: [smoke-testing, deployment-verification, health-checks, post-deployment]
author: vheins
---

# Skill: Smoke Test Suite

## Purpose
Generate a fast (<5 min), focused suite to verify critical post-deployment functionality.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `application_description`| string | Yes | Features and critical paths |
| `tech_stack` | string | Yes | e.g., "Node.js + Express" |
| `environment` | string | No | staging/production |

## Instructions
- **Focus**: Test health checks, authentication, core CRUD, and key integrations only.
- **Speed**: Ensure each test completes in <30s; avoid large datasets or complex setup.
- **Infrastructure**: Verify connectivity to DB, Cache, External APIs, and File Systems.
- **Signal**: Return a clear exit code and actionable error messages for failure.
- **Env-Aware**: Use environment-specific URLs and test accounts; skip inapplicable tests.
- **Trigger**: Integrate with CI/CD to trigger automated rollbacks on failure.

## Edge Cases
| Case | Strategy |
|------|----------|
| Cleanup | Use dedicated test accounts; clean up generated data post-run. |
| Flaky | Add limited retry logic specifically for external dependency checks. |
| Diff | Use conditional execution for environment-specific features. |

## Workflow
```mermaid
flowchart TD
    A([Start: Smoke Test Suite]) --> B[Parse inputs]
    B --> C{Environment?}
    C -- production --> D[Use safe accounts, read-only ops]
    C -- staging/default --> E[Use standard accounts, full CRUD]
    D & E --> F[Infra Health Checks]
    F --> G[Auth Tests]
    G --> H[Core Feature Tests]
    H --> I{< 30s?}
    I -- No --> J[Simplify setup/data]
    I -- Yes --> K
    J & K --> L[Error Handling Tests]
    L --> M{Side effects?}
    M -- Yes --> N[Clean up data]
    M -- No --> O
    N & O --> P{External APIs?}
    P -- Yes --> Q[Add retry logic]
    P -- No --> R
    Q & R --> S[Suite completes < 5m]
    S --> T[Exit non-zero on failure]
    T --> U[CI/CD Integration]
    U --> V([Output: Smoke Test Suite])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Completes in <5 minutes.
- [ ] Critical paths covered.
- [ ] Exits non-zero on failure.
- [ ] CI/CD integration included.
- [ ] Environment-aware.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples, references, added compatibility/license |
| 1.0.0 | 2026-03-20 | Initial release |
