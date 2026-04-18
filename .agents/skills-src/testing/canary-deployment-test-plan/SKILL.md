---
name: canary-deployment-test-plan
description: >
  Designs a canary deployment test plan with traffic split strategy and rollback criteria.
  Do NOT use for blue-green deployments or feature flag testing.
version: "1.1.0"
time_saved: "Manual: 4-6 hours | With skill: 15-20 minutes"
license: Proprietary — Personal Use Only
category: testing
complexity: Advanced
tokens: ~4000
tags: [canary-deployment, progressive-delivery, rollback, traffic-splitting]
author: vheins
---

# Skill: Canary Deployment Test Plan

## Purpose
Design a plan for gradual rollout to limited user subsets. Produces traffic split strategies, monitoring criteria, and rollback triggers.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `deployment_description` | string | Yes | Change description and risk level |
| `tech_stack` | string | Yes | e.g., "Kubernetes + Istio" |
| `slo_targets` | string | Yes | e.g., "p99 < 500ms" |

## Instructions
- **Traffic Strategy**: Define stages (e.g., 1% → 5% → 25%), stage duration, and targeting (random/segment).
- **Monitoring**: Specify key metrics (error rate, latency) with statistical significance requirements.
- **Rollback**: Define automated triggers (threshold breaches) and manual procedures with recovery targets.
- **Promotion**: Set metric bounds and minimum observation times for stage progression.
- **Implementation**: Provide exact CLI commands for the specific stack.
- **Incident Response**: Define notification paths and communication templates.

## Edge Cases
| Case | Strategy |
|------|----------|
| Stateful services | Apply sticky routing to ensure users stay on the same version. |
| DB Migrations | Verify backward-compatibility before starting rollout. |
| Third-party | Monitor external API errors separately from internal ones. |

## Workflow
```mermaid
flowchart TD
    A([Start: Canary Deployment Test Plan]) --> B[Parse deployment_description,
tech_stack, slo_targets]
    B --> C[Assess risk level]
    C --> D{Stateful service?}
    D -- Yes --> E[Plan sticky routing]
    D -- No --> F[Standard random split]
    E & F --> G[Define Traffic Split Stages
1% → 5% → 25% → 50% → 100%]
    G --> H[For each stage: define monitoring,
promotion, rollback]
    H --> I{Database migration
required?}
    I -- Yes --> J[Verify backward-compatibility]
    I -- No --> K[Define Monitoring Criteria]
    J --> K[Define Monitoring Criteria
error rate, latency p99, throughput]
    K --> L[Define Automatic Rollback Triggers
threshold breaches → auto rollback]
    L --> M[Define Manual Rollback Procedure
commands, verification]
    M --> N{Third-party
integrations?}
    N -- Yes --> O[Monitor separately]
    N -- No --> P[Define Promotion Criteria
metrics bounds, observation time]
    O --> P
    P --> Q[Define Synthetic Monitoring Tests]
    Q --> R[Write Incident Response Plan
notify, escalate, comms, post-mortem]
    R --> S([Output: Complete Canary Deployment Test Plan])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Gradual traffic stages defined.
- [ ] Automatic rollback triggers included.
- [ ] Procedure for manual rollback documented.
- [ ] Business metrics monitored.
- [ ] Communication plan provided.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: examples/references moved, metadata added |
| 1.0.0 | 2026-03-20 | Initial release |
