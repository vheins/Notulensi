---
name: error-handling-patterns
description: >
  Implement a comprehensive error handling strategy with typed errors, propagation, logging, and user-facing messages.
  Do NOT use for debugging existing errors, writing tests, or logging-only instrumentation.
version: "1.1.0"
time_saved: "Manual: 2–4 hours | With skill: 15–25 minutes"
license: Proprietary — Personal Use Only
category: coding
complexity: Intermediate
tokens: ~3000
tags: [error-handling, exceptions, typed-errors, error-propagation, resilience]
author: vheins
---

# Skill: Error Handling Patterns

## Purpose
Implement a comprehensive, resilient error handling strategy including typed errors, structured logging, and safe user-facing messaging.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | e.g., "TypeScript + Express" |
| `module_code` | string | Yes | Service/Module code needing patterns |
| `error_scenarios` | string | Yes | e.g., "DB failure", "Auth timeout" |

## Instructions
- **Error Types**: Define a typed hierarchy (Base class with code/status/isOperational). Use idiomatic stack patterns (Result types, custom exceptions).
- **Implementation**: Catch errors at the correct layer. Distinguish operational vs. programmer errors. Propagate with context (wrapping).
- **Logging**: Implement structured levels: ERROR (outage), WARN (retry success), INFO (transitions), DEBUG (trace). Include Correlation IDs.
- **Messaging**: Map errors to helpful, non-revealing user-facing messages.
- **Centralization**: Create a global handler (middleware) for consistent response formatting and final logging.

## Edge Cases
| Case | Strategy |
|------|----------|
| Async errors | Ensure boundaries catch promise rejections; avoid silent swallows. |
| 3rd-Party errors | Wrap external exceptions in domain-specific types to prevent leakage. |
| Transient failures | Implement exponential backoff retry logic (Rate limits, timeouts). |

## Error Flow
```mermaid
flowchart TD
    A([Start: Error Handling Patterns]) --> B[Analyze codebase & error surface]
    B --> C{Error types identified?}
    C -- No --> D[Enumerate: validation / IO / network / business / unexpected]
    C -- Yes --> E[Classify by layer: API / service / repo / infra]
    D --> E
    E --> F{Has existing error hierarchy?}
    F -- Yes --> G[Audit: gaps, inconsistencies, leaking internals]
    F -- No --> H[Design base error class + domain subclasses]
    G --> H
    H --> I[Define error contract: code, message, context, stack]
    I --> J{Async or sync context?}
    J -- Async --> K[Wrap with try/catch + async boundary handlers]
    J -- Sync --> L[Wrap with try/catch + guard clauses]
    J -- Both --> K & L
    K & L --> M[Add global / top-level error boundary]
    M --> N{External integrations present?}
    N -- Yes --> O[Map 3rd-party errors → internal domain errors]
    N -- No --> P[Implement logging: structured, with context, no PII]
    O --> P
    P --> Q{User-facing API?}
    Q -- Yes --> R[Sanitize error responses: hide internals, return safe codes]
    Q -- No --> S[Internal error propagation only]
    R & S --> T[Write recovery / retry logic where applicable]
    T --> U[Document error catalog per module]
    U --> V([Output: Consistent error handling layer])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
1. Is the error hierarchy typed?
2. Are operational vs programmer errors separate?
3. Is internal context redacted for users?
4. Are logs structured and contextual?
5. is the central handler used?

## MCP Dependencies
- `@upstash/context7-mcp`: Library documentation and examples.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples/references, added compatibility/license |
| 1.0.0 | 2026-03-20 | Initial release |
