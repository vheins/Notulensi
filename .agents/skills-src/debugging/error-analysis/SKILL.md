---
name: error-analysis
description: >
  Identify root cause, affected component, and concrete fix from error messages and stack traces.
  Do NOT use for performance profiling, memory leak detection, or architectural reviews.
version: "1.1.0"
time_saved: "Manual: 1–2 hours | With skill: 5–10 minutes"
license: Proprietary — Personal Use Only
category: debugging
complexity: Beginner
tokens: ~2500
tags: [error, stack-trace, exception, root-cause, debugging]
author: vheins
---

# Skill: Error Analysis

## Purpose
Rapidly triage error messages and stack traces to pinpoint root causes, affected modules, and regression fixes.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | e.g., "Node.js + Postgres" |
| `error_message` | string | Yes | Full exception message |
| `stack_trace` | string | No | Raw stack output or symptoms |
| `context` | string | Yes | Relevant code or recent changes |

## Instructions
- **Classification**: Categorize as Runtime, Logic, Configuration, or Dependency error.
- **Trace**: Map stack from top frame to origin; explain the **WHY**.
- **Assessment**: Define affected component and blast radius/side effects.
- **Remediation**: Provide minimal fix with before/after code comparison.
- **Verification**: Write regression test case following local conventions.
- **Fallback**: If no trace, generate ranked hypotheses and reproduction steps.

## Edge Cases
| Case | Strategy |
|------|----------|
| No Trace | Analyze patterns; provide hypotheses and reproduction steps. |
| Minified Code | Request source maps; proceed with available info while noting limits. |
| Cascading Errors | Trace propagation to the innermost (original) cause. |

## Analysis Workflow
```mermaid
flowchart TD
    A([Start: Error Analysis]) --> B[Parse inputs]
    B --> C{Stack trace
available?}
    C -- No --> D[Analyze error type for known patterns]
    D --> E[Generate ranked hypotheses with reasoning]
    E --> F[Recommend minimal reproduction steps]
    C -- Yes --> G[Classify Error Type]
    G --> H{Error class?}
    H -- Runtime --> I[Unhandled exception]
    H -- Logic --> J[Wrong output, no throw]
    H -- Configuration --> K[Missing/wrong config]
    H -- Dependency --> L[Module missing/version mismatch]
    I & J & K & L --> M{Cascading errors?}
    M -- Yes --> N[Identify innermost cause, trace propagation]
    M -- No --> O[Trace stack from top to origin]
    N --> O
    O --> P{Minified/obfuscated?}
    P -- Yes --> Q[Note limitation, request source map, proceed]
    P -- No --> R[Explain WHY error occurs]
    Q --> R
    R --> S[Identify affected component + blast radius]
    S --> T[Provide minimal fix with before/after code & reasoning]
    T --> U[Write regression test case]
    U --> V([Output: 5-Section Report])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Root cause identified (not just symptom).
- [ ] Blast radius defined.
- [ ] Fix is minimal.
- [ ] Test is regression-proof.
- [ ] Minification limits noted.

## MCP Dependencies
- `@upstash/context7-mcp`: Library documentation and examples.
- `@modelcontextprotocol/server-sequential-thinking`: Complex reasoning.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples/references, added compatibility/license |
| 1.0.0 | 2026-03-20 | Initial release |
