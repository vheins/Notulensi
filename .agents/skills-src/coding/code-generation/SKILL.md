---
name: code-generation
description: >
  Use to generate production-ready code for a new feature, function, class,
  or module from a description. Activate for writing new code from scratch
  with error handling, inline documentation, and a self-review checklist.
  Do NOT use for refactoring existing code, code review, or test generation.
version: "1.1.0"
time_saved: "Manual: 2–4 hours | With skill: 10–20 minutes"
license: Proprietary — Personal Use Only
category: coding
complexity: Intermediate
tokens: ~3000
tags: [code-generation, feature-implementation, production-ready, error-handling]
author: vheins
---

# Skill: Code Generation

## Purpose
Generate complete, production-ready code for a specified feature, including error handling, documentation, and a self-review checklist.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | e.g., "TypeScript + Express + PostgreSQL" |
| `feature_description` | string | Yes | Clear summary of target feature (1–5 sentences) |
| `context` | string | Yes | Existing code, interfaces, or architectural constraints |

## Instructions
- **Implementation**: Produce full, runnable code without placeholders.
- **Error Handling**: Implement idiomatic patterns for input validation, service failures, and domain edge cases.
- **Documentation**: Add inline comments for "why" logic, performance trade-offs, and security choices.
- **Verification**: Provide a 6-point checklist (Error paths, Config/Env, Security, Isolation, Style, Scale).
- **Ambiguity**: State all assumptions explicitly before generating code if requirements are unclear.

## Edge Cases
| Case | Strategy |
|------|----------|
| Ambiguous spec | List assumptions; implement the most common interpretation. |
| Missing context | Generate standalone code; note need for local adaptation. |
| Requirement conflict | Priority: Existing codebase patterns > Request specifics; flag conflict. |

## Refactoring Workflow
```mermaid
flowchart TD
    A([Start: feature_description + tech_stack + context]) --> B{feature_description\nclear?}
    B -- Ambiguous --> C[State assumptions explicitly\nbefore writing code]
    B -- Clear --> D{context provided?}
    C --> D
    D -- Empty --> E[Generate standalone code\nnote: may need adaptation\nask for interface/model defs]
    D -- Provided --> F{feature conflicts\nwith context patterns?}
    F -- Yes --> G[Flag conflict\nexplain trade-off\nimplement best-fit approach]
    F -- No --> H[Write full implementation\nno placeholder TODOs]
    E --> H
    G --> H
    H --> I[Add error handling\ninvalid input + external failures + edge cases]
    I --> J[Add inline comments\nwhy not what + trade-offs + security notes]
    J --> K[Self-review checklist\n6 items: errors + config + security\ntestability + style + scale]
    K --> L{Any checklist item\nfails?}
    L -- Yes --> M[Fix before output\nor flag explicitly]
    L -- No --> N([Output: Production-ready code\n+ Self-review checklist])
    M --> N
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
1. Is the solution the simplest possible?
2. Are failure modes handled?
3. Does it scale 10x in load/size?
4. Are security implications addressed?
5. Is the output testable and observable?

## MCP Dependencies
- `@upstash/context7-mcp`: Library documentation and examples.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples to examples/, references to references/, added compatibility and license fields |
| 1.0.0 | 2026-03-20 | Initial release |
