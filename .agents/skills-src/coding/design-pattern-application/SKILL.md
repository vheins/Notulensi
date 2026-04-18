---
name: design-pattern-application
description: >
  Use when a developer has a design problem and needs help identifying and implementing the most
  appropriate design pattern. Activate for structuring code around a recurring
  architectural challenge, applying OOP or functional patterns, or improving extensibility.
  Do NOT use for refactoring without a pattern goal, API design, or database schema design.
version: "1.1.0"
time_saved: "Manual: 2–4 hours | With skill: 15–25 minutes"
license: Proprietary — Personal Use Only
category: coding
complexity: Advanced
tokens: ~4000
tags: [design-patterns, architecture, oop, solid, extensibility, maintainability]
author: vheins
---

# Skill: Design Pattern Application

## Purpose
Identify, justify, and implement the optimal design pattern for a specific architectural challenge.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | e.g., "Java + Spring Boot" |
| `problem_description` | string | Yes | Core design issue and maintenance pain points |
| `context` | string | Yes | Existing structure, constraints, or related modules |

## Instructions
- **Recommendation**: Propose a specific pattern. Explain why it fits the problem in 2–3 sentences.
- **Alternatives**: List 2 alternatives; explain why the recommended one is superior for this case.
- **Implementation**: Provide complete, runnable code using idiomatic features (interfaces, generics, etc.).
- **Usage**: Show a realistic scenario demonstrating the pattern in the target domain.
- **Trade-offs**: Detail what becomes easier, harder, and anti-pattern conditions (when NOT to use).

## Edge Cases
| Case | Strategy |
|------|----------|
| Multiple valid patterns | Implement both in brief; recommend based on existing codebase conventions. |
| Existing anti-pattern | Identify it, explain why it's harmful, and provide a migration path. |
| Functional stack | Adapt OOP patterns to functional equivalents (e.g., Strategy → HOF). |

## Design Logic
```mermaid
flowchart TD
    A([Start: problem_description + tech_stack + context]) --> B{Anti-pattern\nin existing context?}
    B -- Yes --> C[Name the anti-pattern\nExplain why it's problematic\nRecommend migration path]
    B -- No --> D
    C & D --> E{Functional language\ne.g. Elixir, Haskell?}
    E -- Yes --> F[Adapt to functional equivalents:\nStrategy → higher-order functions\nObserver → pub/sub with processes]
    E -- No --> G[Apply OOP/structural patterns]
    F & G --> H{Problem fits\nmultiple patterns equally?}
    H -- Yes --> I[Implement both in abbreviated form\nRecommend based on team conventions\nin context]
    H -- No --> J[Select single best pattern]
    I & J --> K[Pattern Recommendation\nName the pattern\nExplain in 2-3 sentences\nwhy it fits THIS specific problem\nnot a generic description]
    K --> L[Alternatives Considered\n2 alternative patterns:\nwhy each could work\nwhy recommended is better for this case]
    L --> M[Implementation\nComplete and runnable\nIdiomatic language features:\ninterfaces, generics, decorators\nInline comments on key structural elements]
    M --> N[Usage Example\nRealistic scenario from problem domain\nshowing how developer uses the pattern]
    N --> O[Trade-offs\nWhat it makes easier\nWhat it makes harder\nWhen NOT to use this pattern\nanti-pattern conditions]
    O --> P([Output: Pattern recommendation\n+ Alternatives + Implementation\n+ Usage example + Trade-offs])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
1. Is the solution the simplest possible?
2. Are trade-offs clearly stated?
3. Does it scale to the problem size?
4. Are idiomatic language features used?
5. Is the output testable?

## MCP Dependencies
- `@upstash/context7-mcp`: Library documentation and examples.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples to examples/, references to references/, added compatibility and license fields |
| 1.0.0 | 2026-03-20 | Initial release |
