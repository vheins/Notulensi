---
name: feature-flag-implementation
description: >
  Implement a feature flag system for toggles, gradual rollout, and targeting.
  Do NOT use for configuration management, A/B test analytics, or infrastructure feature flags.
version: "1.1.0"
time_saved: "Manual: 2–4 hours | With skill: 15–25 minutes"
license: Proprietary — Personal Use Only
category: coding
complexity: Intermediate
tokens: ~3000
tags: [feature-flags, feature-toggles, gradual-rollout, canary-release, a-b-testing]
author: vheins
---

# Skill: Feature Flag Implementation

## Purpose
Implement a complete feature flag system supporting toggles, percentage rollouts, and targeting.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | e.g., "Node.js + Redis" |
| `feature_description` | string | Yes | Behavior, audience, and rollout plan |
| `flag_requirements` | string | Yes | Storage backend and evaluation context |

## Instructions
- **Schema**: Define Name (kebab-case), Type (boolean/percentage/user list), Default fallback, and Metadata (owner/expiry).
- **Storage**: Implement CRUD operations and a zero-downtime update strategy for configurations (JSON/YAML).
- **Engine**: Build evaluation logic using user ID hashing for deterministic rollouts. Include caching and failure fallbacks.
- **Integration**: Create a clean abstraction layer (no raw env checks). pass evaluated flags from server to client.
- **Cleanup**: Define the lifecycle (Dev -> Test -> Rollout -> Full -> Cleanup). Identify stale flags (>30 days at 100%).

## Edge Cases
| Case | Strategy |
|------|----------|
| Hot paths | Apply aggressive short-TTL in-memory caching. |
| Flag dependencies | Avoid nesting; combine into single multi-state flags. |
| Client-side logic | Evaluate on server; pass results to frontend at page load. |

## Implementation Logic
```mermaid
flowchart TD
    A([Start: Feature Flag Implementation]) --> B[Define flag scope: release/experiment/ops/permission]
    B --> C{Flag storage strategy?}
    C -- Config file --> D[Static flags: env vars or JSON config]
    C -- Remote service --> E[Integrate flag provider: LaunchDarkly/Unleash]
    C -- Database --> F[DB-backed flags with admin UI]
    D & E & F --> G[Define flag schema: name, type, default, description]
    G --> H{Flag type?}
    H -- Boolean --> I[Simple on/off toggle]
    H -- Multivariate --> J[Multiple variants with weights]
    H -- Percentage rollout --> K[Gradual rollout by user/session hash]
    I & J & K --> L[Implement flag evaluation function]
    L --> M{Targeting rules needed?}
    M -- Yes --> N[Add user/context targeting: segment, attribute, env]
    M -- No --> O[Wrap feature code with flag check]
    N --> O
    O --> P{Flag affects multiple layers?}
    P -- Yes --> Q[Propagate flag context: API → service → DB layer]
    P -- No --> R[Single-layer guard only]
    Q & R --> S[Add flag state to observability/logging]
    S --> T{Stale flags cleanup?}
    T -- Yes --> U[Mark flags with expiry/owner/ticket ref]
    T -- No --> V[Document flag inventory + rollback procedure]
    U --> V
    V --> W([Output: Feature flag system with targeting & rollback])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
1. Is the evaluation deterministic?
2. Are fallbacks safe?
3. Is it abstracted from business logic?
4. Is there a cleanup plan?
5. is the system observable?

## MCP Dependencies
- `@upstash/context7-mcp`: Library documentation and examples.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples/references, added compatibility/license |
| 1.0.0 | 2026-03-20 | Initial release |
