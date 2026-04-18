---
name: fix-suggestion
description: >
  Provide a targeted, minimal fix for an identified bug with before/after code and a test case.
  Do NOT use for root cause analysis, architectural refactoring, or performance optimization.
version: "1.1.0"
time_saved: "Manual: 1–3 hours | With skill: 10–20 minutes"
license: Proprietary — Personal Use Only
category: debugging
complexity: Intermediate
tokens: ~3000
tags: [fix, patch, bug-fix, code-change, test-case, debugging]
author: vheins
---

# Skill: Fix Suggestion

## Purpose
Produce surgical bug fixes with before/after comparisons and regression-preventing test cases.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | e.g., "TypeScript + NestJS" |
| `bug_description`| string | Yes | Behavior and impact |
| `code` | string | Yes | The buggy logic |
| `root_cause` | string | Yes | Confirmed origin of the issue |

## Instructions
- **Explanation**: Clarify why fix resolves root cause; detail side effects/trade-offs.
- **Before/After**: Show original logic (marked) vs. fixed logic (explained).
- **Checklist**: List non-code requirements (Migrations, Config, Deps, Docs).
- **Validation**: Provide minimal test reproducing bug and verifying fix.
- **Risk Assessment**: Identify areas needing re-testing for regressions.
- **Fallback**: If no code, provide structural fix patterns and target logic.

## Edge Cases
| Case | Strategy |
|------|----------|
| No Code provided | Provide fix patterns and pseudocode for the bug type. |
| Breaking Change | Flag explicitly; suggest migration path or feature flags. |
| Multi-Fix options | Present options with trade-off analysis and recommendation. |

## Fix Flow
```mermaid
flowchart TD
    A([Start: Fix Suggestion]) --> B[Parse inputs]
    B --> C{Code
available?}
    C -- No --> D[Describe fix pattern]
    D --> E[Provide pseudocode, list lines to change]
    C -- Yes --> F{Root cause known?}
    F -- No --> G[Infer root cause from symptoms & code]
    F -- Yes --> H[Explain WHY bug occurs & fix resolves it]
    G --> H
    H --> I{Breaking change?}
    I -- Yes --> J[Flag, provide migration path, suggest rollout]
    I -- No --> K{Multiple valid fixes?}
    J --> K
    K -- Yes --> L[Present options with trade-offs & recommendation]
    K -- No --> M[Show Before Code with marked lines]
    L --> M
    M --> N[Show After Code with change comments]
    N --> O[Fix Checklist: Config, DB, Deps, Docs]
    O --> P[Write test case verifying fix]
    P --> Q[Identify Regression Risk areas]
    Q --> R([Output: 6-Section Report])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Fix is minimal.
- [ ] Behavior preserved (except fix).
- [ ] Test is regression-proof.
- [ ] Side effects noted.
- [ ] Fix is idiomatic.

## MCP Dependencies
- `@upstash/context7-mcp`: Library documentation and examples.
- `@modelcontextprotocol/server-sequential-thinking`: Complex reasoning.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples/references, added compatibility/license |
| 1.0.0 | 2026-03-20 | Initial release |
