---
name: chaos-engineering-scenario
description: >
  Designs chaos engineering experiments to test system resilience and failure recovery.
  Do NOT use for functional testing or performance load testing.
version: "1.1.0"
time_saved: "Manual: 6-8 hours | With skill: 20-30 minutes"
license: Proprietary — Personal Use Only
category: testing
complexity: Advanced
tokens: ~4500
tags: [chaos-engineering, resilience-testing, fault-injection, reliability]
author: vheins
---

# Skill: Chaos Engineering Scenario

## Purpose
Design experiments for deliberate failure injection to test system resilience and recovery mechanisms.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `system_description` | string | Yes | Arch/components (e.g., "K8s + Node") |
| `tech_stack` | string | Yes | Target technology stack |
| `chaos_scope` | string | No | network, compute, app (default: all) |

## Instructions
- **Steady State**: Define normal behavior metrics (error rate, latency) and SLOs.
- **Hypotheses**: Formulate falsifiable statements focusing on resilience mechanisms.
- **Experiment Design**: Specify failure type, blast radius (1 pod/AZ), duration, and rollback abort criteria.
- **Failure Types**: Test network (latency), compute (OOM), storage (disk full), and app (crash) scenarios.
- **Safety**: Start with smallest radius; monitor SLOs; run during low-traffic periods.
- **Implementation**: Provide step-by-step instructions for tools (Chaos Monkey, Litmus, FIS).

## Edge Cases
| Case | Strategy |
|------|----------|
| Production | Always start in staging; validate extensively before prod execution. |
| Stateful | Explicitly avoid experiments that risk data loss/corruption. |
| Compliance | Document regulatory restrictions for finance/healthcare sectors. |

## Workflow
```mermaid
flowchart TD
    A([Start: Chaos Engineering Scenario]) --> B[Parse system_description,
tech_stack, chaos_scope]
    B --> C[Define Steady State
metrics, SLOs]
    C --> D{chaos_scope
specified?}
    D -- Yes --> E[Focus on scope: network/compute/storage/app]
    D -- No --> F[Cover all failure types]
    E & F --> G[Formulate Hypothesis
'System will X when Y']
    G --> H{Falsifiable?}
    H -- No --> I[Revise to be measurable]
    H -- Yes --> J[Design Experiment
Failure, Blast radius, Duration,
Rollback, Success, Monitoring]
    I --> J
    J --> K{Blast radius
acceptable?}
    K -- Too large --> L[Reduce scope:
1 pod → 1 AZ → 1 service]
    K -- OK --> M[Define Safety Controls
Automated rollback, monitor SLOs]
    L --> M
    M --> N{Stateful system?}
    N -- Yes --> O[Warn: risk of data loss.
Start in staging only]
    N -- No --> P{Regulatory
restrictions?}
    O & P --> Q{Regulatory
restrictions?}
    Q -- Yes --> R[Document restrictions.
Limit to staging]
    Q -- No --> S[Write Step-by-Step Execution
Monitoring, Abort, Expected results]
    R --> S
    S --> T[Select Tools
Chaos Monkey / Litmus / AWS FIS]
    T --> U([Output: 4-6 Chaos Experiments])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Steady state defined with measurable metrics.
- [ ] Clear hypothesis per experiment.
- [ ] Blast radius and rollback defined.
- [ ] Abort criteria specified.
- [ ] Realistic schedule provided.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples, references, added metadata |
| 1.0.0 | 2026-03-20 | Initial release |
