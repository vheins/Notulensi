---
name: capacity-planning
description: Estimates infrastructure capacity based on load projections. DO NOT use for system design review, dev cost estimation, or DB schema planning.
version: "1.1.0"
time_saved: "Manual: 4–8 hours | With skill: 20–40 minutes"
license: Proprietary — Personal Use Only
category: planning
complexity: Advanced
tokens: ~5000
tags: [capacity-planning, infrastructure, load-estimation, scaling, cost, bottleneck]
author: vheins
---

# Skill: Capacity Planning

## Purpose
Estimate infrastructure requirements (Compute, DB, Storage, Bandwidth) based on load projections and growth rates.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `system_description` | string | Yes | Components |
| `expected_load` | string | Yes | DAU, RPS, Growth |
| `tech_stack` | string | Yes | Platform/Stack |

## Instructions
- **Load Analysis**: Break down Peak/Avg RPS, Read/Write ratio, and seasonal spike patterns.
- **Resources**: Map components to CPU, Memory, Storage (Launch vs 1-year), and Bandwidth in a table.
- **Scaling**: Define Horizontal/Vertical triggers, thresholds, and stateful vs stateless handling.
- **Costing**: Estimate monthly costs per category (Compute/DB/Storage) for launch and 1-year scale.
- **Bottlenecks**: Identify top 3 bottlenecks manifest levels and provide mitigation strategies.
- **Clarification**: Request specific DAU/RPS if provided load info is vague or missing.

## Edge Cases
| Case | Strategy |
|------|----------|
| No projections | Stop; request DAU and peak throughput estimates first. |
| Bursty load | Model steady-state and burst capacity (auto-scaling) separately. |
| GPU | Include specific GPU instance types and non-standard scaling logic. |

## Workflow
```mermaid
flowchart TD
    A([Start: Capacity Planning]) --> B{expected_load\nprovided?}
    B -- Vague/Missing --> C[Ask for: DAU, peak RPS,\ndata volume before proceeding]
    C --> B
    B -- Yes --> D[Load Analysis:\nbreak down peak vs avg RPS\nread/write ratio\ndata ingestion rate\nconcurrent users]
    D --> E{Load pattern:\nbursty or steady?}
    E -- Bursty --> F[Model steady-state AND\nburst capacity separately\nrecommend auto-scaling policies]
    E -- Steady --> G[Calculate Resource Requirements\nper component: CPU + Memory\n+ Storage + Bandwidth]
    F --> G
    G --> H{System includes\nGPU workloads?}
    H -- Yes --> I[Add GPU instance types\nto resource table\nnote different scaling strategy]
    H -- No --> J[Write Scaling Strategy\nhorizontal/vertical per component\ntrigger metric + threshold\nstateless/stateful handling]
    I --> J
    J --> K[Estimate Monthly Cost\ncompute + DB + storage + bandwidth\nat launch AND 1-year scale\nspecify cloud provider]
    K --> L[Identify Top 3 Bottlenecks\nwhy + at what load level\nmitigation strategy]
    L --> M[State all assumptions\nexplicitly for developer validation]
    M --> N([Output: 5-section capacity plan\n600–1000 words])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] RPS calculations include peak scenarios.
- [ ] Resource table covers all components.
- [ ] Scaling triggers are quantified.
- [ ] Cost estimates specify cloud provider.
- [ ] Assumptions are listed.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples/references, added compatibility/license |
| 1.0.0 | 2026-03-20 | Initial release |
