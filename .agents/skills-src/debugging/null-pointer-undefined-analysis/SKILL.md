---
name: null-pointer-undefined-analysis
description: >
  Resolve null pointer exceptions, undefined reference errors, and "Cannot read property" errors with defensive patterns.
  Do NOT use for type system design, schema validation, or general error handling architecture.
version: "1.1.0"
time_saved: "Manual: 30–90 minutes | With skill: 5–15 minutes"
license: Proprietary — Personal Use Only
category: debugging
complexity: Intermediate
tokens: ~3500
tags: [null-pointer, undefined, optional-chaining, null-safety, defensive-programming, debugging]
author: vheins
---

# Skill: Null Pointer / Undefined Analysis

## Purpose
Resolve null and undefined reference errors by identifying the source and applying defensive patterns.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | e.g., "TypeScript + React" |
| `error_message` | string | Yes | Full error + failing property |
| `code` | string | Yes | Failing section or flow |
| `context` | string | Yes | Source of null (API, DB, input) |

## Instructions
- **Source Identification**: Trace origin (Uninitialized, function return, missing field, unawaited async).
- **Access Point**: Identify failing line and explain WHY it fails (property/method on null).
- **Defensive Fix**: Apply appropriate stack pattern:
  - **JS/TS**: `?.`, `??`, type guards.
  - **Java**: `Optional<T>`, `requireNonNull`, `@NonNull`.
  - **Python**: `is not None`, `getattr()`, Walrus operator.
- **Null Object Pattern**: Recommend `NullUser` or `NoOpHandler` if checks are scattered.
- **Type Safety**: Recommend improvements (e.g., `strictNullChecks`, `Optional[T]`).
- **Fallback**: If no code, trace likely source from error and provide stack templates.

## Edge Cases
| Case | Strategy |
|------|----------|
| No Code | Activate fallback; provide likely source and null-safe templates. |
| External API | Recommend defensive deserialization and document contract violation. |
| Deep Nested | Recommend flattening access or optional chaining. |

## Workflow
```mermaid
flowchart TD
    A([Start: Null/Undefined Analysis]) --> B[Parse inputs]
    B --> C{Code\navailable?}
    C -- No --> D[Identify null source from error+context]
    D --> E[Provide null-safe template]
    C -- Yes --> F[Trace Null Source]
    F --> G{Where does null originate?}
    G -- Uninitialized --> H[Declared, not assigned]
    G -- Function return --> I[DB/API/array.find]
    G -- Optional field --> J[Missing in API/config]
    G -- Async unawaited --> K[Accessed before resolution]
    G -- Conditional --> L[If-block not executed]
    H & I & J & K & L --> M[Identify exact access point]
    M --> N{Null access depth?}
    N -- Deeply nested --> O[Optional chaining / flatten model]
    N -- Single level --> P[Apply targeted pattern]
    O --> P{Tech stack?}
    P -- JS/TS --> Q[Optional chaining, coalescing, type guards, non-null]
    P -- Java --> R[Optional, requireNonNull, @NonNull]
    P -- Python --> S[is not None, getattr, Walrus]
    Q & R & S --> T{Scattered null checks?}
    T -- Yes --> U[Null Object Pattern: NullUser/EmptyList]
    T -- No --> V[Add Type Safety: strictNullChecks, Optional, mypy]
    U --> V
    V --> W([Output: 5-Section Report])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Source identified (not just point).
- [ ] Fix is stack-specific.
- [ ] Before/after code included.
- [ ] Type safety improvement noted.
- [ ] Simple patterns preferred.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples/references, added compatibility/license |
| 1.0.0 | 2026-03-20 | Initial release |
