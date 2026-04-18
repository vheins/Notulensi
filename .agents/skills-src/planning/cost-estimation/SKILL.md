---
name: cost-estimation
description: >
  Generates a development cost estimate by breaking down features into tasks, applying hourly rates, and adding contingency.
  Do NOT use for infra costs, sprint planning, or feature decomposition without cost context.
version: "1.1.0"
time_saved: "Manual: 2–4 hours | With skill: 15–30 minutes"
license: Proprietary — Personal Use Only
category: planning
complexity: Intermediate
tokens: ~3500
tags: [cost-estimation, project-planning, budgeting, hourly-rates, task-breakdown, timeline]
author: vheins
---

# Skill: Cost Estimation

## Purpose
Produce a defensible development cost estimate covering tasks, roles, contingency, and estimated timeline.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `feature_list` | string | Yes | Targets for estimation |
| `tech_stack` | string | Yes | Technology stack |
| `team_composition` | string | Yes | Roles involved |
| `hourly_rates` | string | Yes | Rate per role |

## Instructions
- **Task Breakdown**: List tasks per feature with Role, Low/High/Mid hours, and Complexity.
- **Cost Calculation**: Multiply midpoint hours by provided role rates in a markdown table.
- **Grand Total**: Sum sub-totals; add a 20% contingency (30-40% for high-risk items) and provide final estimate.
- **Timeline**: Estimate calendar duration based on 6 productive hours/day/person; identify critical paths.
- **Rules**: If rates or team info are missing, ask for them; do not invent market rates.
- **Validation**: State all assumptions (e.g., "API spec is final") and explicit exclusions (e.g., "hosting").

## Edge Cases
| Case | Strategy |
|------|----------|
| No Rates | Stop; request explicit rates before performing any calculations. |
| Vague List | Provide a "Rough Order of Magnitude" (ROM) estimate (±50%) and flag it. |
| High-Risk | Recommend and justify a 40% contingency for items like "Real-time sync". |

## Workflow
```mermaid
flowchart TD
    A([Start: Cost Estimation]) --> B{hourly_rates\nprovided?}
    B -- No --> C[Ask for rates\nDo not assume]
    C --> B
    B -- Yes --> D{feature_list\nspecific?}
    D -- No --> E[Apply ROM estimate ±50%\nFlag as ROM]
    D -- Yes --> F[Break features into tasks]
    E --> G
    F --> G[Calculate Cost per Task\nmidpoint hrs × rate]
    G --> H[Build Total Cost table\nAdd 20% contingency]
    H --> I{High-complexity\nfeatures?}
    I -- Yes --> J[Recommend 30-40% contingency\nfor those features]
    I -- No --> K[Estimate Timeline\n6hrs/day, parallel tasks, critical path]
    J --> K
    K --> L[Write Assumptions and Exclusions]
    L --> M([Output: 5-section estimate\n500–900 words])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Hourly rates applied as provided.
- [ ] Contingency buffer included and justified.
- [ ] Timeline accounts for parallel work.
- [ ] Assumptions and Exclusions explicit.
- [ ] Tasks mapped to specific roles.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples/references, added compatibility/license |
| 1.0.0 | 2026-03-20 | Initial release |
