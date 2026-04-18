---
name: interface-contract-implementation
description: >
  Implements all methods of a defined interface, abstract class, or contract with full type safety, error handling, and documentation.
  Do NOT use for designing interfaces from scratch, API contract design, or generating tests only.
version: "1.1.0"
time_saved: "Manual: 1–3 hours | With skill: 10–20 minutes"
license: Proprietary — Personal Use Only
category: coding
complexity: Intermediate
tokens: ~3000
tags: [interface, contract, implementation, type-safety, abstraction]
author: vheins
---

# Skill: Interface Contract Implementation

## Purpose
Implement all methods of a defined contract with full type safety, error handling, and documentation.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | e.g., "TypeScript + Node.js" |
| `interface_definition` | string | Yes | Full definition of the contract |
| `context` | string | Yes | Purpose, dependencies, and constraints |

## Instructions
- **Implementation**: Code every method. Use full type system features (Generics, Unions, Enums). No stubs.
- **Documentation**: Provide TSDoc/JSDoc comments for every method (Description, Params, Returns, Errors, Side Effects).
- **Error Handling**: Implement a clear approach (Exceptions/Result types). Distinguish between fatal and recoverable states.
- **Usage**: Show a realistic example of instantiating and using the implementation.
- **Assumptions**: Explicitly list all assumptions if method behavior is ambiguous from the definition.

## Edge Cases
| Case | Strategy |
|------|----------|
| Optional methods | Implement required logic; note skipped overrides. |
| Generics | Apply concrete parameters for the context; note generalization paths. |
| Circular deps | Flag in context; suggest lazy injection or event decoupling. |

## Implementation Flow
```mermaid
flowchart TD
    A([Start: Interface Implementation]) --> B[Parse interface definition]
    B --> C[Enumerate all methods]
    C --> D{Ambiguous
behavior?}
    D -- Yes --> E[State assumption explicitly]
    D -- No --> F[Design constructor:
inject dependencies]
    E --> F
    F --> G[Implement methods]
    G --> H{External
dependency?}
    H -- Yes --> I[Wrap with error boundary,
translate to domain error]
    H -- No --> J[Pure logic with guard clauses]
    I & J --> K{Uses generics?}
    K -- Yes --> L[Apply concrete type params]
    K -- No --> M{Optional methods?}
    L --> M
    M -- Yes --> N[Implement required only,
note optional skipped]
    M -- No --> O{Circular dependency?}
    N --> O
    O -- Yes --> P[Flag it, suggest lazy injection
or event decoupling]
    O -- No --> Q[Add doc comment per method]
    P --> Q
    Q --> R[Write usage example]
    R --> S[Document error handling strategy]
    S --> T([Output: Complete contract implementation])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
1. Are all methods implemented?
2. Is it 100% type-safe?
3. Are error boundaries implemented?
4. Are doc comments complete?
5. is there a usage example?

## MCP Dependencies
- `@upstash/context7-mcp`: Library documentation and examples.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples/references, added compatibility/license |
| 1.0.0 | 2026-03-20 | Initial release |
