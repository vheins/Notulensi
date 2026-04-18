---
name: snapshot-test-generation
description: >
  Generates snapshot tests for UI components, API responses, or serialized data.
  Do NOT use for behavioral or logic tests.
version: "1.1.0"
time_saved: "Manual: 1-2h | With skill: 5-10m"
license: Proprietary — Personal Use Only
category: testing
complexity: Beginner
tokens: ~2000
tags: [snapshot-testing, ui-testing, regression-testing, component-testing]
author: vheins
---

# Skill: Snapshot Test Generation

## Purpose
Generate snapshot tests to capture rendered UI or API outputs and detect unintended visual/contract changes.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `component_or_endpoint` | string | Yes | Code or URL to snapshot |
| `tech_stack` | string | Yes | e.g., "React + Jest" |
| `snapshot_scope` | string | No | component, api, or data |

## Instructions
- **Meaningful**: Render with realistic props/data; capture loading, error, empty, and populated states.
- **Dynamic Values**: Mock timestamps, UUIDs, and random IDs to fixed, deterministic values.
- **Maintenance**: Use inline snapshots for small outputs; external files for large ones.
- **Pairing**: Use snapshots for appearance/contract; pair with unit tests for behavioral logic.
- **Policy**: Document snapshot update policies to prevent "lazy updating" of regressions.

## Edge Cases
| Case | Strategy |
|------|----------|
| Dynamic | Always mock random/time-based values to ensure deterministic tests. |
| Large | Use targeted property assertions instead of full-file snapshots. |
| Drift | Document the specific scenarios requiring a manual snapshot update. |

## Workflow
```mermaid
flowchart TD
    A([Start: Snapshot Test Generation]) --> B[Parse inputs]
    B --> C{Scope?}
    C -- component --> D[Render component with props]
    C -- api-response --> E[Capture API response]
    C -- serialized-data --> F[Capture serialized data]
    C -- auto-detect --> G[Infer scope]
    D & E & F & G --> H[Mock dynamic values]
    H --> I[Identify states]
    I --> J[Empty state]
    I --> K[Populated state]
    I --> L{Loading state?}
    L -- Yes --> M[Loading state]
    L -- No --> N
    I --> O{Error state?}
    O -- Yes --> P[Error state]
    O -- No --> Q
    J & K & M & N & P & Q --> R{Output size?}
    R -- Small --> S[Use inline snapshot]
    R -- Large --> T[Use external file]
    S & T --> U[Add comments and policies]
    U --> V[Pair with behavioral tests]
    V --> W([Output: Snapshot Test File])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Dynamic values mocked.
- [ ] Multiple states captured.
- [ ] Inline snapshots used for small snippets.
- [ ] Paired with behavioral tests.
- [ ] Update policy defined.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples, references, added compatibility/license |
| 1.0.0 | 2026-03-20 | Initial release |
