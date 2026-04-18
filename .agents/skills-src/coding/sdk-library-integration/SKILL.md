---
name: sdk-library-integration
description: >
  Use to integrate a third-party SDK or library into their application
  with a proper abstraction layer, error handling, retry logic, and a mock for testing.
  Activate for adding a new external service integration.
  Do NOT use for building SDKs from scratch, API contract design, or webhook handling.
version: "1.1.0"
time_saved: "Manual: 2–4 hours (integration + abstraction + mock + error handling) | With skill: 15–25 minutes"
license: Proprietary — Personal Use Only
category: coding
complexity: Intermediate
tokens: ~3000
tags: [sdk, integration, abstraction, retry-logic, testing-mock, third-party]
author: vheins
---

# Skill: SDK/Library Integration

## Purpose
Integrate third-party SDKs using an abstraction layer, domain-specific types, retry logic, and test mocks to decouple external dependencies from application logic.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | e.g., "TypeScript + Node.js" |
| `sdk_name` | string | Yes | Name and version (e.g., "Stripe v14") |
| `integration_requirements` | string | Yes | Supported ops, error cases, config |

## Instructions
- **Abstraction**: Define an interface with business-named methods (e.g., `chargeCustomer`, not `sdk.charges.create`). Use domain types in signatures.
- **Implementation**: Create a singleton wrapper for the SDK. Map responses/errors to domain types. Add retry logic (Backoff + Jitter) for transient failures.
- **Mocks**: Provide a stub implementation for unit tests that simulates responses and errors without network calls.
- **Dependency Injection**: Show how to wire the real vs. mock implementation based on configuration/environment flags.
- **Usage**: Provide an example of application code calling the abstraction.

## Edge Cases
| Case | Strategy |
|------|----------|
| No built-in retry | Implement exponential backoff wrapper/decorator. |
| Breaking changes | Document migration path and version-specific constraints. |
| Multiple clients | Split into focused interfaces per service/responsibility. |

## Workflow
```mermaid
flowchart TD
    A([Start: SDK/Library Integration]) --> B[Analyze integration requirements]
    B --> C{Multiple SDK operations across different services?}
    C -- Yes --> D[Create separate focused interfaces per service]
    C -- No --> E[Single interface for this integration]
    D & E --> F[Define abstraction interface with business-named methods]
    F --> G[Use domain types in signatures, not SDK types]
    G --> H[Implement SDK class: init client as singleton]
    H --> I[Map SDK responses → domain types]
    I --> J[Translate SDK errors → domain errors]
    J --> K{SDK has built-in retry?}
    K -- Yes --> L[Configure retry settings]
    K -- No --> M[Implement exponential backoff with jitter]
    L & M --> N{Known breaking changes in SDK version?}
    N -- Yes --> O[Note migration considerations]
    N -- No --> P
    O & P --> Q[Log SDK calls at DEBUG level with sanitized params]
    Q --> R[Implement mock class: same interface, no network calls]
    R --> S[Mock returns configurable responses]
    S --> T[Mock can simulate error scenarios]
    T --> U[Wire DI: real impl in prod, mock in tests]
    U --> V{Config-driven selection?}
    V -- Yes --> W[Environment flag selects real vs mock]
    V -- No --> X[Manual injection in test setup]
    W & X --> Y[Write usage example: app code uses interface only]
    Y --> Z([Output: Abstraction + SDK impl + mock + DI setup])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
1. Is the SDK completely hidden?
2. Are domain types used?
3. Is retry logic implemented?
4. Is there a test mock?
5. is the logger sanitized?

## MCP Dependencies
- `@upstash/context7-mcp`: Library documentation and examples.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples to examples/, references to references/, added compatibility and license fields |
| 1.0.0 | 2026-03-20 | Initial release |
