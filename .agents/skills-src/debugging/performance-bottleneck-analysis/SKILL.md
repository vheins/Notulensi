---
name: performance-bottleneck-analysis
description: >
  Identify top bottlenecks from performance profiles/metrics.
  Prioritize by impact and provide optimization recommendations.
  Do NOT use for memory leak detection, DB schema design, or capacity planning.
version: "1.1.0"
time_saved: "Manual: 4–8 hours | With skill: 30–60 mins"
license: Proprietary — Personal Use Only
category: debugging
complexity: Advanced
tokens: ~5000
tags: [performance, bottleneck, profiling, optimization, latency, debugging]
author: vheins
---

# Skill: Performance Bottleneck Analysis

## Purpose
Analyze performance profiles/metrics to identify and prioritize top bottlenecks (CPU, I/O, memory, network).

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | e.g., "Go + PostgreSQL" |
| `performance_profile` | string | Yes | Profiler output, APM trace |
| `code` | string | No | Hot path section/module |
| `context` | string | Yes | Traffic, SLA targets, changes |

## Instructions
- **Inventory**: List bottlenecks with location, type, and current cost (% time/latency).
- **Prioritization**: Rank by Impact × Effort using a Priority Matrix table.
- **Remediation**: Provide top 3 recommendations with root cause, technique, and before/after snippets.
- **Quick Wins**: List <1 hour optimizations with high confidence.
- **Measurement**: Define tracking metrics, baselines, and post-optimization targets.
- **Fallback**: If no profile, identify likely categories from symptoms and provide profiling commands.

## Edge Cases
| Case | Strategy |
|------|----------|
| No Profile | Activate fallback; provide stack-specific profiling and load test commands. |
| Multi-Service | Identify critical path; prioritize highest-latency service. |
| Conflicts | Flag trade-offs (e.g., cache vs real-time); align with SLA. |

## Workflow
```mermaid
flowchart TD
    A([Start: Performance Bottleneck Analysis]) --> B[Parse inputs]
    B --> C{Profile
available?}
    C -- No --> D[Identify categories from symptoms]
    D --> E[Provide profiling commands]
    E --> F[Provide load test script]
    C -- Yes --> G[Build Bottleneck Inventory]
    G --> H[Extract location, type, cost]
    H --> I{Multiple services?}
    I -- Yes --> J[Identify critical path]
    I -- No --> K
    J --> K[Build Priority Matrix]
    K --> L[Top 3 Recommendations]
    L --> M{Conflicts?}
    M -- Yes --> N[Flag trade-off]
    M -- No --> O
    N --> O[List Quick Wins]
    O --> P[Define Measurement Plan]
    P --> Q([Output: 5-Section Report])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Priority Matrix ranked correctly.
- [ ] Quantified improvements provided.
- [ ] Before/after snippets included.
- [ ] SLA targets addressed.
- [ ] Quick wins distinguished.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples, references, added metadata |
| 1.0.0 | 2026-03-20 | Initial release |
