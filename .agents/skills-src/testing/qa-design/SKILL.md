---
name: qa-design
description: >
  Designs structured test scenarios (Positive, Negative, Monkey, Security).
  Do NOT use for writing actual test code (use unit-test-generation or e2e-test-scenario-writing).
version: "1.1.0"
time_saved: "Manual: 2-4h | With skill: 20-40m"
license: Proprietary — Personal Use Only
category: testing
complexity: Intermediate
tokens: ~2500
tags: [qa, test-design, test-scenarios, security-testing, monkey-testing, positive-negative]
author: vheins
---

# Skill: QA Design

## Purpose
Design language-agnostic test scenarios (Positive, Negative, Monkey, Security) describing *what* to test based on requirements.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `feature_description` | string | Yes | Rules and purpose |
| `user_stories` | string | Yes | "As a [role]..." |
| `tech_stack` | string | No | Technology stack |
| `roles` | string | No | User roles |

## Instructions
- **Positive Testing**: Write scenarios for happy paths using valid inputs and permissions.
- **Negative Testing**: Design tests for validation (invalid format, missing fields), boundaries, and unauthorized access.
- **Monkey Testing**: Simulate chaos (rapid actions, concurrent requests, extreme inputs).
- **Security Testing**: Verify AuthZ/AuthN boundaries, IDOR, and input injection (XSS/SQLi).
- **Reporting**: Present as markdown tables (ID | Title | Preconditions | Steps | Expected | Priority).
- **Summary**: End with a Coverage Summary mapping scenarios to user stories.

## Edge Cases
| Case | Strategy |
|------|----------|
| No Stories | Stop and request acceptance criteria first. |
| Async Flows | Specifically test the trigger and eventual outcome state. |
| Auth | Test escalation paths and cross-role access boundaries. |

## Workflow
```mermaid
flowchart TD
    A([Start: QA Design]) --> B[Parse inputs]
    B --> C{Stories provided?}
    C -- No --> D[Ask for acceptance criteria]
    C -- Yes --> E[Analyze behaviors]
    D --> E
    E --> F[Positive Testing]
    F --> F1[Write happy paths]
    E --> G[Negative Testing]
    G --> G1[Validation/Errors]
    E --> H[Monkey Testing]
    H --> H1[Chaos/Exploratory]
    E --> I[Security Testing]
    I --> I1{Roles provided?}
    I1 -- Yes --> I2[AuthZ per role]
    I1 -- No --> I3[Generic roles]
    I2 & I3 --> I4[IDOR, Injection]
    F1 & G1 & H1 & I4 --> J{Async feature?}
    J -- Yes --> K[Test trigger and outcome]
    J -- No --> L
    K & L --> M[Format as markdown tables]
    M --> N[Write Coverage Summary]
    N --> O([Output: 4 Tables + Summary])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Both positive and negative cases included.
- [ ] Boundary conditions covered.
- [ ] Authorization scenarios included.
- [ ] Traceable to user stories.
- [ ] No test code included.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: tables used, metadata updated |
| 1.0.0 | 2026-03-20 | Initial release |
