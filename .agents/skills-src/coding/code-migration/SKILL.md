---
name: code-migration
description: >
  Use to migrate existing code from one framework, language version, or
  technology stack to another. Activate for porting code with compatibility
  notes, breaking change identification, and maintaining test coverage through the migration.
  Do NOT use for refactoring within the same stack, dependency upgrades, or new feature development.
version: "1.1.0"
time_saved: "Manual: 4–8 hours | With skill: 30–60 minutes"
license: Proprietary — Personal Use Only
category: coding
complexity: Advanced
tokens: ~4500
tags: [migration, porting, framework-upgrade, compatibility, breaking-changes]
author: vheins
---

# Skill: Code Migration

## Purpose
Migrate code between tech stacks, producing idiomatic implementation, a compatibility report (breaking changes), and migrated tests.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `source_stack` | string | Yes | e.g., "Python 2.7 + Flask" |
| `target_stack` | string | Yes | e.g., "Python 3.11 + FastAPI" |
| `code` | string | Yes | Logic to migrate (function/module/class) |
| `migration_scope` | string | Yes | Full module, specific function, tests, or config |

## Instructions
- **Analysis**: Identify constructs with direct equivalents vs. those requiring significant rewrites or workarounds.
- **Implementation**: Produce idiomatic (not literal) code. Preserve business logic and apply target-stack error handling.
- **Compatibility**: List breaking changes, impact on consumers, and required follow-up actions.
- **Testing**: Adapt existing tests or create new ones for the target framework (Happy path + Error cases).
- **Checklist**: Provide a numbered list of post-migration manual steps (Env vars, DB migrations, CI updates).

## Edge Cases
| Case | Strategy |
|------|----------|
| No direct equivalent | Recommend closest alternative; flag for manual review. |
| Large codebase (>200 lines) | Migrate critical sections; provide strategy for the remainder. |
| Global state/Circular deps | Flag as high risk; suggest refactoring approach. |

## Migration Logic
```mermaid
flowchart TD
    A([Start: source_stack + target_stack\ncode + migration_scope]) --> B{code size?}
    B -- "> ~200 lines" --> C[Migrate critical sections only\nprovide strategy for the rest]
    B -- "≤ ~200 lines" --> D[Pre-migration analysis]
    C --> D
    D --> E{Construct has direct\nequivalent in target?}
    E -- Yes --> F[Map directly\nnote any behavioral difference]
    E -- No --> G{Workaround available?}
    G -- Yes --> H[Implement workaround\nflag as manual review needed]
    G -- No --> I[Recommend closest alternative\nexplain behavioral gap]
    F & H & I --> J{Global state or\ncircular deps?}
    J -- Yes --> K[Flag as migration risk\nsuggest refactor approach]
    J -- No --> L[Write migrated code\nidiomatic target patterns\npreserve all business logic]
    K --> L
    L --> M[Add inline comments\nwhere non-obvious decisions made]
    M --> N[Build breaking changes report\nwhat changed + impact + action per item]
    N --> O{Tests exist\nin source?}
    O -- Yes --> P[Rewrite tests for\ntarget test framework]
    O -- No --> Q[Write basic tests\nhappy path + key error cases]
    P & Q --> R[Migration checklist\nmanual steps post-apply]
    R --> S([Output: Migrated code\n+ Breaking changes report\n+ Tests + Checklist])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
1. Is the solution the simplest possible?
2. Are failure modes handled?
3. Does it scale 10x in load/size?
4. Are security implications addressed?
5. Is the output testable and observable?

## MCP Dependencies
- `@upstash/context7-mcp`: Library documentation and examples.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples to examples/, references to references/, added compatibility and license fields |
| 1.0.0 | 2026-03-20 | Initial release |
