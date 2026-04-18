---
name: brainstorm-feature
description: Produces a production-ready technical design for a feature (actors, invariants, state machine, data model, API) WITHOUT code. DO NOT use for writing code or sprint planning.
version: "1.1.0"
time_saved: "Manual: 2–4 hours | With skill: 15–30 minutes"
license: Proprietary — Personal Use Only
category: planning
complexity: Advanced
tokens: ~3000
tags: [brainstorm, architecture, technical-design, research, state-machine, api-design]
author: vheins
---

# Skill: Brainstorm Feature

## Purpose
Produces a production-ready technical design brief covering logic, state, data, and performance targets. **ZERO CODE ALLOWED**.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `feature_name` | string | Yes | Feature name |
| `business_context` | string | Yes | Problem and value |
| `tech_stack` | string | Yes | Target stack |
| `constraints` | string | No | Latency, offline, etc. |

## Instructions
- **Analysis**: Define Actors, Roles, Scope (In/Out), and Invariants (e.g., `balance >= 0`).
- **Benchmarking**: Research industry patterns (Stripe/Shopify) to identify bottlenecks and security requirements.
- **Data Model**: List entities, attributes, and relationships; include a Mermaid ERD.
- **State Machine**: Map all possible states and valid transitions; include a Mermaid state diagram.
- **API Surface**: Define endpoints (path, method) with abstract validation rules and AuthZ requirements.
- **Performance**: Specify data volume patterns, caching (TTL), locking, and latency/throughput targets.
- **Strict Rule**: Remove ALL code snippets; replace with pseudocode, diagrams, or requirements.

## Edge Cases
| Case | Strategy |
|------|----------|
| Sparse Context | Stop and request business value/user goal details first. |
| Contradictory | Flag conflicting constraints and ask for priority before designing. |
| Existing Code | Acknowledge current implementation and design compatible extensions. |

## Workflow
```mermaid
flowchart TD
    A([Start: Feature Design Brief]) --> B{business_context\nsufficient?}
    B -- No --> C[Ask for clarification\nbefore proceeding]
    C --> B
    B -- Yes --> D{constraints\ncontradict each other?}
    D -- Yes --> E[Flag conflict\nask which takes priority]
    D -- No --> F[Step 1: Requirement Analysis\nActors + Roles\nInvariants\nScope IN/OUT]
    E --> F
    F --> G[Step 2: Global Benchmarking\nresearch large-scale patterns\nStripe/Shopify/Uber blogs\nidentify trade-offs + security requirements]
    G --> H[Step 3A: Data Model\nentity names + attributes\nrelationships\nMermaid ERD diagram]
    H --> I[Step 3B: State Machine\nall possible states\nvalid transitions + guards\nMermaid state diagram]
    I --> J[Step 3C: API Surface\nendpoint list\nvalidation rules abstract\nauth/authz requirements]
    J --> K[Step 3D: Performance & Scalability\ndata volume + query patterns\ncaching strategy + TTL\nconcurrency + locking\ntarget latency/throughput]
    K --> L[Compliance Check:\nZERO code blocks in output?]
    L -- Code found --> M[Remove all code snippets\nreplace with pseudocode/diagrams]
    L -- Clean --> N[Produce Technical Design Brief\nall sections assembled]
    M --> N
    N --> O([Output: Technical Design Brief\n400–800 words, no code])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Business problem addressed.
- [ ] Data model is backward-compatible.
- [ ] Integration points identified.
- [ ] NO code blocks included.
- [ ] State machine is complete.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples/references, added compatibility/license |
| 1.0.0 | 2026-03-20 | Initial release |
