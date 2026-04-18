---
name: test-data-factory-creation
description: >
  Creates test data factories for realistic, randomized, and edge-case test data.
  Do NOT use for production data generation or database seeding.
version: "1.1.0"
time_saved: "Manual: 2-3h | With skill: 10-15m"
license: Proprietary — Personal Use Only
category: testing
complexity: Intermediate
tokens: ~2500
tags: [test-data, factories, fixtures, test-generation]
author: vheins
---

# Skill: Test Data Factory Creation

## Purpose
Generate test data factories (Functions, Classes, Builders) to produce valid, varied, and edge-case data for tests.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `data_model` | string | Yes | Interface or schema |
| `tech_stack` | string | Yes | Stack and library |
| `edge_cases` | string | No | Specific cases to include |

## Instructions
- **Realistic Defaults**: Use meaningful values (not "test"); generate unique emails/IDs.
- **Customization**: Allow field overrides and support partial updates.
- **Edge Cases**: Include empty/null, min/max length, boundary numbers, and invalid formats.
- **Patterns**: Implement using Factory Functions, Classes, or Builder patterns with Traits.
- **Sequences**: Use auto-increment or UUIDs to avoid unique constraint collisions.
- **Relationships**: Compose factories for nested objects or database relationships.

## Edge Cases
| Case | Strategy |
|------|----------|
| Nested | Create separate sub-factories and compose them in the parent. |
| Constraints | Use sequences or randomized unique strings for unique fields. |
| Large data | Optimize for performance if generating bulk datasets for load tests. |

## Workflow
```mermaid
flowchart TD
    A([Start: Factory Creation]) --> B[Parse inputs]
    B --> C[Analyze data model]
    C --> D[Choose Pattern]
    D --> D1{Complexity?}
    D1 -- Simple --> D2[Factory Function]
    D1 -- Complex --> D3[Factory Class]
    D1 -- Fluent --> D4[Builder Pattern]
    D2 & D3 & D4 --> E[Define Realistic Defaults]
    E --> F{Unique values?}
    F -- Yes --> G[Use sequences/UUIDs]
    F -- No --> H
    G & H --> I{Nested objects?}
    I -- Yes --> J[Create separate factories, compose]
    I -- No --> K
    J & K --> L[Create 3-5 Trait Variations]
    L --> M[Create Edge Case Factories]
    M --> M1[Empty/null]
    M --> M2[Max length]
    M --> M3[Boundaries]
    M --> M4[Special chars]
    M --> M5[Invalid formats]
    M1 & M2 & M3 & M4 & M5 --> N{edge_cases specified?}
    N -- Yes --> O[Add specified edge cases]
    N -- No --> P
    O & P --> Q[Show test usage]
    Q --> R([Output: Complete Factory Code])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Defaults are realistic.
- [ ] Uniqueness enforced via sequences.
- [ ] Traits included for common variants.
- [ ] Edge cases comprehensively covered.
- [ ] Usage example provided.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples, references, added compatibility/license |
| 1.0.0 | 2026-03-20 | Initial release |
