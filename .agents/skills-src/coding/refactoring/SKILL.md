---
name: refactoring
description: >
  Use to improve existing code quality — readability, maintainability,
  or performance — without changing its observable behavior. Activate for cleaning up code, reducing complexity, or applying better patterns to working code.
  Do NOT use for adding new features, fixing bugs, or generating code from scratch.
version: "1.1.0"
time_saved: "Manual: 1–3 hours (analysis, rewriting, documenting changes) | With skill: 10–15 minutes"
license: Proprietary — Personal Use Only
category: coding
complexity: Intermediate
tokens: ~3000
tags: [refactoring, code-quality, maintainability, readability, clean-code]
author: vheins
---

# Skill: Refactoring

## Purpose
Improve code quality (readability, maintainability, performance) without altering observable behavior, using stack-idiomatic patterns.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | e.g., "TypeScript + React" |
| `code` | string | Yes | Logic to be refactored |
| `refactoring_goals` | string | Yes | e.g., "Reduce complexity", "Apply Factory pattern" |

## Instructions
- **Behavior Preservation**: Ensure identical outputs for all inputs. Flag bugs separately; do NOT fix them silently.
- **Idiomatic Patterns**: Use ecosystem-standard conventions and libraries.
- **Change Log**: Provide a numbered list of changes covering **What**, **Why**, and **Benefit**.
- **Trade-offs**: Explicitly state any introduced trade-offs (e.g., abstraction vs. traceability).
- **Bug Reporting**: List discovered bugs in a "Bugs Found (Not Fixed)" section.
- **Scope**: Maintain original signatures and features unless goals explicitly dictate changes.

## Edge Cases
| Case | Strategy |
|------|----------|
| Large code blocks | Process in logical chunks (functions/modules); warn about scale risks. |
| Conflicting goals | Prioritize readability; note performance/complexity trade-offs. |
| Clean code | State that no significant improvements are possible; suggest minor style tweaks. |

## Refactoring Flow
```mermaid
flowchart TD
    A([Start: Refactoring]) --> B[Read code + refactoring goals]
    B --> C{Goals conflict?}
    C -- Yes --> D[Flag tension, implement readability-first, note trade-offs]
    C -- No --> E
    D & E --> F{Code already well-written?}
    F -- Yes --> G[State explicitly, suggest minor style improvements only]
    F -- No --> H[Identify issues per goal]
    H --> I{Goal type?}
    I -- Readability --> J[Rename unclear vars/functions, extract helpers, reduce nesting]
    I -- Reduce duplication --> K[Extract shared logic to reusable function/class]
    I -- Apply pattern --> L[Refactor to target pattern: strategy, factory, etc.]
    I -- Reduce complexity --> M[Break large function into smaller focused units]
    I -- Performance --> N[Optimize algorithm, remove redundant ops]
    J & K & L & M & N --> O{Bug found during refactoring?}
    O -- Yes --> P[Add to Bugs Found section — do NOT fix silently]
    O -- No --> Q
    P & Q --> R{Behavior preserved?}
    R -- Uncertain --> S[Add note: verify with existing tests before merging]
    R -- Yes --> T
    S & T --> U{Trade-off introduced?}
    U -- Yes --> V[Document: more abstraction = harder to trace, etc.]
    U -- No --> W
    V & W --> X[Write numbered change log: what, why, benefit per change]
    X --> Y([Output: Refactored code + change log + bugs found])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
1. Is behavior preserved?
2. Are changes idiomatic?
3. Is every change justified?
4. Are trade-offs documented?
5. are bugs flagged but not fixed?

## MCP Dependencies
- `@upstash/context7-mcp`: Library documentation and examples.
- `@modelcontextprotocol/server-sequential-thinking`: Complex reasoning.
- `@modelcontextprotocol/server-memory`: Knowledge graph.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples to examples/, references to references/, added compatibility and license fields |
| 1.0.0 | 2026-03-20 | Initial release |
