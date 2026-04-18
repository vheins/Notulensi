---
name: infinite-loop-detection
description: >
  Identify loop condition failures causing applications to hang, consume 100% CPU, or never terminate.
  Do NOT use for deadlocks, race conditions, or performance optimization of terminating loops.
version: "1.1.0"
time_saved: "Manual: 1–3 hours | With skill: 15–30 minutes"
license: Proprietary — Personal Use Only
category: debugging
complexity: Intermediate
tokens: ~3500
tags: [infinite-loop, loop-invariant, termination, debugging, cpu]
author: vheins
---

# Skill: Infinite Loop Detection

## Purpose
Identify infinite loop conditions by analyzing structure, termination condition, and invariants.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | e.g., "JavaScript + Node.js" |
| `code` | string | Yes | Loop code or function |
| `symptoms` | string | Yes | 100% CPU, hang, timeout, stack overflow |
| `context` | string | Yes | Input data, recent changes |

## Instructions
- **Identification**: Pinpoint failure cause (Var not updated, condition always true, circular structure, missing base case).
- **Analysis**: Identify loop type and components (Init, Condition, Update, Termination invariant).
- **Remediation**:
  - Provide fixed loop with marked fix comment.
  - Add Loop Invariant: "At the start of each iteration, [property] holds".
  - Define Termination Argument: "[Measure] strictly decreases".
- **Defensive Guard**: Add a max-iteration guard template.
- **Verification**: Write test verifying termination within reasonable time/iterations.
- **Fallback**: If no code, provide CPU profiling commands and counter guard templates.

## Edge Cases
| Case | Strategy |
|------|----------|
| No Code | Activate fallback path; provide profiling and guards. |
| Exponential Time | Distinguish from infinite loops; recommend algorithmic improvements. |
| Third-party | Identify triggering input, provide workaround, recommend upstream issue. |

## Workflow
```mermaid
flowchart TD
    A([Start: Infinite Loop Detection]) --> B[Parse inputs]
    B --> C{Code\navailable?}
    C -- No --> D[Provide CPU profiling command]
    D --> E[Identify likely loop patterns]
    E --> F[Add loop counter guard template]
    C -- Yes --> G[Analyze Loop Structure]
    G --> H[Identify loop type & components]
    H --> I{Termination failure cause?}
    I -- Variable never updated --> J[Missing increment/decrement]
    I -- Condition always true --> K[Off-by-one / wrong operator]
    I -- Variable modified --> L[Body overwrites exit condition]
    I -- Circular structure --> M[List/graph cycle, no visited tracking]
    I -- Recursion --> N[Missing/unreachable base case]
    I -- Float comparison --> O[Never reaches exact equality]
    J & K & L & M & N & O --> P{Exponential time?}
    P -- Yes --> Q[Distinguish from infinite loop, recommend algorithmic improvement]
    P -- No --> R[Provide fixed loop with invariant & termination argument]
    Q --> R
    R --> S[Add defensive max-iteration guard]
    S --> T[Write test case verifying termination & output]
    T --> U([Output: 5-Section Report])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Solution is minimal.
- [ ] Failure modes handled.
- [ ] Output is testable/observable.
- [ ] Loop invariant defined.
- [ ] Termination argument provided.

## MCP Dependencies
- `@modelcontextprotocol/server-sequential-thinking`: Complex reasoning.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples/references, added compatibility/license |
| 1.0.0 | 2026-03-20 | Initial release |
