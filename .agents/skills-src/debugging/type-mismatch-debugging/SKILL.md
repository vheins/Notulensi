---
name: type-mismatch-debugging
description: >
  Resolve type mismatch errors, type coercion bugs, or schema validation failures.
  Explain type system behavior and apply correct fixes.
  Do NOT use for null/undefined errors, unrelated runtime exceptions, or type system design.
version: "1.1.0"
time_saved: "Manual: 30–90 mins | With skill: 10–20 mins"
license: Proprietary — Personal Use Only
category: debugging
complexity: Intermediate
tokens: ~3500
tags: [type-mismatch, type-coercion, schema, type-safety, debugging]
author: vheins
---

# Skill: Type Mismatch Debugging

## Purpose
Resolve type mismatch errors by identifying conflicts, explaining behavior, and applying fixes (coercion, schema correction, guards).

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | e.g., "TypeScript + Zod" |
| `error_message` | string | Yes | Full message with expected/actual |
| `code` | string | Yes | Failing code or flow |
| `context` | string | Yes | Data source and expected type |

## Instructions
- **Identification**: State expected/actual types and mismatch location (parameter, return, schema).
- **Behavior Analysis**: Explain rejection/runtime behavior (Static reject, implicit coercion, serialization mismatch).
- **Remediation**:
  - Apply explicit coercion (`Number()`), type guards (`typeof`), or schema fixes.
  - Show before/after code.
- **Schema Alignment**: If API response mismatch, provide corrected interface and validation schema (Zod/Pydantic).
- **Prevention**: Recommend strict mode, boundary validation, or branded types.
- **Fallback**: If no code, identify cause from error and provide type-safe templates.

## Edge Cases
| Case | Strategy |
|------|----------|
| No Code | Identify mismatch from error; provide common causes and templates. |
| Serialization | Provide custom serializer/deserializer; explain contract. |
| JS Coercion | Explain rules; provide explicit fix; recommend ESLint rules. |

## Workflow
```mermaid
flowchart TD
    A([Start: Type Mismatch Debugging]) --> B[Parse tech_stack\nerror_message, code, context]
    B --> C{Code\navailable?}
    C -- No --> D[Identify expected vs actual type]
    D --> E[Describe common causes]
    E --> F[Provide type-safe template]
    C -- Yes --> G[Identify Type Conflict]
    G --> H[State Expected/Actual/Location]
    H --> I{Type system behavior?}
    I -- Static error --> J[Compiler rejects]
    I -- Implicit coercion --> K[JS silent conversion]
    I -- Schema mismatch --> L[Response != interface]
    I -- Serialization --> M[Type format mismatch]
    J & K & L & M --> N{Fix strategy?}
    N -- Explicit coercion --> O[Number/String/parseInt]
    N -- Type guard --> P[typeof/instanceof]
    N -- Schema fix --> Q[Update interface]
    N -- Validation --> R[Zod/Pydantic]
    N -- Assertion --> S[as string]
    O & P & Q & R & S --> T{Serialization mismatch?}
    T -- Yes --> U[Provide serializer/explain contract]
    T -- No --> V
    U --> V{JS coercion bug?}
    V -- Yes --> W[Explain rules, fix, add ESLint]
    V -- No --> X
    W --> X[Show corrected interface + schema]
    X --> Y[Add Type Safety: strict mode, validation, branded types]
    Y --> Z([Output: 5-Section Report + Fixes])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Expected/Actual types stated.
- [ ] Fix choice explained.
- [ ] Before/after code included.
- [ ] Runtime validation added (if applicable).
- [ ] Prevention strategy stack-specific.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples, references, added metadata |
| 1.0.0 | 2026-03-20 | Initial release |
