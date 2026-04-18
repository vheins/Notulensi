---
name: test-case-design
description: >
  Designs comprehensive test cases from requirements using equivalence partitioning and boundary value analysis. Do NOT use for writing test code.
version: "1.1.0"
time_saved: "10-15 minutes"
license: Proprietary — Personal Use Only
category: testing
complexity: Intermediate
tokens: ~7500
tags: [test-design, test-cases, equivalence-partitioning, boundary-analysis]
author: vheins
---

# Skill: Test Case Design

## Purpose
Generate structured test case catalogs from requirements using standard analysis techniques (Equivalence Partitioning, BVA).

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `requirements` | string | Yes | Requirements/User Story |
| `tech_stack` | string | Yes | Target technology stack |
| `test_level` | string | No | unit, integration, or e2e |

## Instructions
- **Equivalence**: Partition inputs into valid/invalid classes; design tests for each class.
- **Boundaries**: Test numeric/length boundaries (Min, Min+1, Max, Max+1, Max-1).
- **Decisions**: Create tables for complex rules; cover all condition combinations.
- **State**: Document valid transitions; test each valid flow and one invalid per state.
- **Error Guessing**: Identify likely traps (nulls, empty strings, concurrency).
- **Structure**: Format as Catalog: ID | Name | Objective | Preconditions | Steps | Expected | Priority.

## Edge Cases
| Case | Strategy |
|------|----------|
| Vague | Flag ambiguities and ask for clarification before finalizing. |
| Non-functional | Include specific performance or security boundary cases. |
| Complex State | Use Mermaid state transition diagrams for visualization. |

## Workflow
```mermaid
flowchart TD
    A([Start]) --> B[Parse inputs]
    B --> C[Identify input domains]
    C --> D[Equivalence Partitioning]
    C --> E[Boundary Value Analysis]
    C --> F{Complex rules?}
    F -- Yes --> G[Decision Table Testing]
    F -- No --> H
    C --> I{State changes?}
    I -- Yes --> J[State Transition Testing]
    I -- No --> K
    D & E & G & H & J & K --> L[Error Guessing]
    L --> M[Format test cases]
    M --> N{Test level?}
    N -- unit --> O[Function-level focus]
    N -- integration --> P[Component-interaction focus]
    N -- system/acceptance --> Q[E2E focus]
    N -- all --> R[Cover all levels]
    O & P & Q & R --> S[Group test cases]
    S --> T[Write Summary]
    T --> U([Output: Test Catalog])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Equivalence classes identified.
- [ ] Boundaries tested (min/max/invalid).
- [ ] Positive/Negative scenarios balanced.
- [ ] Priorities assigned by risk.
- [ ] No implementation code included.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples/references, added fields |
| 1.0.0 | 2026-03-20 | Initial release |
