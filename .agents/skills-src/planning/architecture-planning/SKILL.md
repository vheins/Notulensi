---
name: architecture-planning
description: Produces a system architecture overview (components, data flow, tech rationale, scalability). DO NOT use for single-feature, DB schema, or API design.
version: "1.1.0"
time_saved: "Manual: 4–8 hours | With skill: 20–40 minutes"
license: Proprietary — Personal Use Only
category: planning
complexity: Advanced
tokens: ~5000
tags: [architecture, system-design, components, data-flow, scalability, technology-decisions]
author: vheins
---

# Skill: Architecture Planning

## Purpose
Generate a comprehensive system architecture plan including component mapping, data flow, tech rationale, and scaling strategies.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `project_description`| string | Yes | High-level system overview |
| `tech_stack` | string | Yes | Core technologies |
| `scale_requirements` | string | Yes | Load, DAU, SLA targets |

## Instructions
- **Components**: Define names, responsibilities, and exposed/consumed interfaces for every system block.
- **Data Flow**: Map at least 2 critical user journeys with numbered steps; distinguish sync vs async paths.
- **Rationale**: Document tech choices including rejected alternatives and accepted trade-offs.
- **Scalability**: Address horizontal/vertical scaling, stateful vs stateless components, and caching strategies.
- **Diagram**: Provide an ASCII box-and-arrow diagram with protocol/data labels.
- **Pathing**: Default to monolith if system scale or boundaries are ambiguous; describe the extraction path.

## Edge Cases
| Case | Strategy |
|------|----------|
| Scale Conflict | Flag tech/scale mismatches; recommend compatible alternatives. |
| Open Stack | Recommend a specific, opinionated stack with rationale; ask for confirmation. |
| Microservices | If requested but DAU is low, propose a modular monolith first. |

## Workflow
```mermaid
flowchart TD
    A([Start: Architecture Planning]) --> B{scale_requirements\nprovided and consistent?}
    B -- Missing/Vague --> C[Ask for clarification:\nDAU, uptime, latency targets]
    C --> B
    B -- Yes --> D{tech_stack conflicts\nwith scale requirements?}
    D -- Yes --> E[Flag mismatch explicitly\nrecommend compatible alternative]
    D -- No --> F{tech_stack open-ended?}
    F -- Yes --> G[Recommend specific stack\nwith rationale\nask developer to confirm]
    F -- No --> H[List Component Overview\nname + responsibility + tech + interfaces]
    G --> H
    H --> I{Monolith or\ndistributed?}
    I -- Ambiguous --> J[Default to monolith\nfor given scale\nnote extraction path]
    I -- Clear --> K[Describe Data Flow\nfor 2 critical user journeys\nsync vs async explicit]
    J --> K
    K --> L[Write Technology Decisions\nwith rationale + rejected alternatives\n+ trade-offs accepted]
    L --> M[Write Scalability Considerations\nhorizontal/vertical per component\nbottleneck identification + caching]
    M --> N[Produce ASCII Architecture Diagram\ncomponents + connections\nlabeled with protocol/data type]
    N --> O([Output: 5-section architecture plan\n600–1200 words])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Components have clear boundaries.
- [ ] Data flows cover critical paths.
- [ ] Tech choices are justified.
- [ ] Scalability strategy is quantified.
- [ ] Diagram included.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples/references, added compatibility/license |
| 1.0.0 | 2026-03-20 | Initial release |
