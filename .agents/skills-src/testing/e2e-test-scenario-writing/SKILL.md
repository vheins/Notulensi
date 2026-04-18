---
name: e2e-test-scenario-writing
description: >
  Generates end-to-end test scenarios for critical user journeys using Playwright, Cypress, or Selenium.
  Do NOT use for unit tests, integration tests, or API testing.
version: "1.1.0"
time_saved: "Manual: 4-6 hours | With skill: 15-20 minutes"
license: Proprietary — Personal Use Only
category: testing
complexity: Advanced
tokens: ~4000
tags: [e2e-testing, user-journey, playwright, cypress, selenium]
author: vheins
---

# Skill: E2E Test Scenario Writing

## Purpose
Generate end-to-end test scenarios simulating real user journeys through the application UI to verify completeness.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `user_journey` | string | Yes | e.g., "Signup, verify, complete profile" |
| `tech_stack` | string | Yes | e.g., "React + Playwright" |
| `app_url` | string | No | Base URL (default: http://localhost:3000) |

## Instructions
- **Flows**: Simulate full interactions (click, type, navigate); verify completion and handle critical errors.
- **Selectors**: Prefer `data-testid` and semantic roles; avoid brittle CSS/XPath.
- **Async**: Use explicit waits for elements/network; NO arbitrary `sleep()`.
- **Verification**: Check UI states, URL changes, auth tokens, and network payloads.
- **Lifecycle**: Perform setup (create data/users) and teardown (cleanup/reset) around tests.
- **Structure**: Apply Page Object Model for complex UIs; extract common helper actions.

## Edge Cases
| Case | Strategy |
|------|----------|
| Auth | Create test users in `beforeEach`; reuse session tokens; avoid redundant logins. |
| External | Use sandbox accounts or mocks for email/payment services. |
| Flaky UI | Use Page Object Model to centralize selector management and improve stability. |

## Workflow
```mermaid
flowchart TD
    A([Start: E2E Test Scenario Writing]) --> B[Parse user_journey,
tech_stack, app_url]
    B --> C[Identify entry point]
    C --> D[Setup: Create test data/users]
    D --> E{Auth required?}
    E -- Yes --> F[Login once in beforeEach
Reuse session/token]
    E -- No --> G[Start public entry point]
    F & G --> H[Write Happy Path Test
Simulate realistic interactions]
    H --> I{External services?}
    I -- Email --> J[Use test/sandbox/mock]
    I -- Payment --> K[Use mock gateway]
    I -- None --> L[Write Selectors
Prefer: data-testid
Avoid: CSS/XPath]
    J & K & L --> M[Handle Async Operations
Wait for elements/networks
NO arbitrary sleep]
    M --> N[Add Assertions
UI state, URL, Storage, Networks]
    N --> O{Complex UI?}
    O -- Yes --> P[Apply Page Object Model]
    O -- No --> Q[Extract helper functions]
    P & Q --> R[Write Critical Error Path Tests]
    R --> S[Teardown: Clean up data
Reset state]
    S --> T([Output: E2E Test File
3-5 scenarios])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Selectors are robust (data-testid).
- [ ] Async operations use explicit waits.
- [ ] Test data cleaned up.
- [ ] Happy path and errors tested.
- [ ] Multi-point assertions included.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples, references, added metadata |
| 1.0.0 | 2026-03-20 | Initial release |
