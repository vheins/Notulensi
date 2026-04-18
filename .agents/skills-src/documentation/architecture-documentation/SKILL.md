---
name: architecture-documentation
description: >
  Generate a system architecture overview covering components, data flow, ADRs, deployment, and trade-offs.
  Do NOT use for API endpoint documentation, code-level design patterns, or IaC generation.
version: "1.1.0"
time_saved: "Manual: 4-6 hours | With skill: 20-30 minutes"
license: Proprietary — Personal Use Only
category: documentation
complexity: Advanced
tokens: ~20500
tags: [architecture, system-design, components, data-flow, adr, deployment, tech-choices]
author: vheins
---

# Agent Optimized: Architecture Documentation

## Directives
- **System Purpose**: Describe problem solved, primary users, and scope boundaries.
- **Component Inventory**: Provide Table (Name, Role, Technology, Interaction).
- **Data Flow**: Numbered sequence (min 6 steps) tracing a representative user request.
- **ADR-Lite**: Include min 4 entries (Decision, Context, Rationale, Trade-off).
- **Deployment Topology**: Detail packaging, network boundaries, scaling, and environment separation.
- **Trade-offs**: List min 4 limitations with impact and mitigation.

## Constraints
- **Inference**: Derive components from inputs; do not invent unimplied components.
- **Assumptions**: Infer topology if missing from `{{deployment_target}}` and flag as "Suggested Baseline".
- **Clarification**: Request input if `{{system_name}}`, `{{system_description}}`, or `{{tech_stack}}` are contradictory.

## Strategy: Edge Cases
| Case | Strategy |
|------|----------|
| Minimal stack | Infer MV components, flag as assumed, ask for confirmation. |
| Monolithic system | Document internal modules as components; note scaling limitations. |
| Sensitive data | Add security note (encryption, access control) in deployment topology. |

## Format
- Six sections with markdown headers (`##`).
- Table for Component Inventory.
- Numbered list for Data Flow.
- Bold field labels for ADR-Lite.
- Word Count: 800–1,400 words.

## Verification: Senior Review
- [ ] Component Inventory covers all tech stack items?
- [ ] Data Flow traces realistic end-to-end path (min 6 steps)?
- [ ] ADR-Lite entries name considered alternatives?
- [ ] Deployment Topology addresses scaling/networking?

## Metadata
- **Path**: `.agents/documents/design/architecture/`
- **Mermaid**:
```mermaid
flowchart TD
    A([Start]) --> B{Inputs provided?}
    B -- No --> C[Ask for clarification]
    C --> B
    B -- Yes --> D[Write System Purpose]
    D --> E[Build Component Inventory]
    E --> F{Missing implied components?}
    F -- Yes --> G[Infer and flag as assumed]
    F -- No --> H[Trace primary Data Flow]
    G --> H
    H --> I{Secondary flow?}
    I -- Yes --> J[Document secondary flow]
    I -- No --> K[Write ADR-Lite entries]
    J --> K
    K --> L{deployment_target?}
    L -- No --> M[Infer topology, flag suggested]
    L -- Yes --> N[Document Deployment Topology]
    M --> N
    N --> O{Sensitive data?}
    O -- Yes --> P[Add security note]
    O -- No --> Q[Write Trade-offs section]
    P --> Q
    Q --> R([Output: 6-section architecture doc])
```
