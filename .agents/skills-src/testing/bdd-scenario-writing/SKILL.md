---
name: bdd-scenario-writing
description: >
  Generate BDD scenarios in Gherkin format (Given/When/Then) for a feature or user story.
  Do NOT use for test automation code or unit tests.
version: "1.1.0"
time_saved: "Manual: 2-3 hours | With skill: 10-15 minutes"
license: Proprietary — Personal Use Only
category: testing
complexity: Intermediate
tokens: ~3000
tags: [bdd, gherkin, cucumber, behavior-driven-development, acceptance-testing]
author: vheins
---

# Skill: BDD Scenario Writing

## Purpose
Generate BDD scenarios in Gherkin format for features and user stories to bridge business requirements and implementation.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `feature_description` | string | Yes | Target feature or user story |
| `tech_stack` | string | Yes | e.g., "Node.js + Cucumber" |
| `user_role` | string | No | Primary user persona |

## Instructions
- **Gherkin Syntax**: Use standard Feature, Background, Scenario, and Scenario Outline blocks.
- **Business Language**: Write in domain-specific, non-technical language from the user perspective.
- **Scenarios**: Cover happy paths, alternatives, errors, edge cases, and business rules.
- **Variations**: Use `Scenario Outline` with `Examples` tables for data-driven tests.
- **Atoms**: Ensure each scenario tests exactly one behavior and is independent.
- **Step Hints**: Suggest patterns for reusable step definitions.

## Edge Cases
| Case | Strategy |
|------|----------|
| Complex rules | Break into multiple focused, atomic scenarios. |
| Technical steps | Rewrite in domain language; add comment explaining business intent. |
| Shared steps | Identify and document as reusable step definitions. |

## Workflow
```mermaid
flowchart TD
    A([Start: BDD Scenario Writing]) --> B[Parse feature_description
tech_stack, user_role]
    B --> C{User role provided?}
    C -- Yes --> D[Scope scenarios to role perspective]
    C -- No --> E[Use generic user perspective]
    D & E --> F[Identify behaviors in feature]
    F --> G{Complex business rules?}
    G -- Yes --> H[Break into focused scenarios]
    G -- No --> I[Single scenario per behavior]
    H & I --> J[Write Feature block]
    J --> K[Write Background section]
    K --> L[For each behavior: write Scenario]
    L --> M[1. Happy Path
Given valid preconditions
When user performs action
Then expected outcome]
    L --> N[2. Alternative Paths
Different valid inputs]
    L --> O[3. Error Paths
Invalid inputs
Unauthorized access
System failures]
    L --> P[4. Edge Cases
Boundary values
Empty inputs
Business rule violations]
    M & N & O & P --> Q{Multiple data variations?}
    Q -- Yes --> R[Write Scenario Outline
with Examples table]
    Q -- No --> S[Keep as Scenario]
    R & S --> T{Steps contain technical terms?}
    T -- Yes --> U[Rewrite in domain language
add comment for business intent]
    T -- No --> V
    U --> V{Steps reusable?}
    V -- Yes --> W[Document as reusable steps]
    V -- No --> X
    W & X --> Y([Output: Complete Gherkin Feature File
with user story format, 8-15 scenarios, business-readable])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Scenarios in business language.
- [ ] One behavior per scenario.
- [ ] All business rules covered.
- [ ] Scenario Outlines used for data variations.
- [ ] Understandable by non-technical stakeholders.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured examples and references, added metadata |
| 1.0.0 | 2026-03-20 | Initial release |
