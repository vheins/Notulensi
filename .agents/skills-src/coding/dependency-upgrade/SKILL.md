---
name: dependency-upgrade
description: >
  Use to upgrade one or more dependencies to newer versions, including
  breaking change analysis, step-by-step migration instructions, and a rollback plan.
  Activate for library upgrades, framework version bumps, or security patch updates.
  Do NOT use for adding new dependencies, removing unused packages, or full stack migrations.
version: "1.1.0"
time_saved: "Manual: 2–5 hours | With skill: 15–30 minutes"
license: Proprietary — Personal Use Only
category: coding
complexity: Intermediate
tokens: ~3000
tags: [dependencies, upgrade, breaking-changes, package-management, security-patches]
author: vheins
---

# Skill: Dependency Upgrade

## Purpose
Plan and execute dependency upgrades with breaking change analysis, migration steps, and rollback strategies.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | e.g., "Node.js + npm" |
| `current_dependencies` | string | Yes | `package.json` excerpt or list |
| `target_versions` | string | Yes | e.g., "react: 18.3.0" or "latest" |

## Instructions
- **Analysis**: Map version jumps (e.g., 16.x → 18.x). Identify breaking changes, deprecated APIs, and new peer dependencies.
- **Assessment**: Rate impact (HIGH/MEDIUM/LOW) based on code change requirements.
- **Migration**: Provide ordered, numbered steps with exact commands and required code adjustments. Include verification checks.
- **Rollback**: List commands to restore state. Identify non-reversible changes (DB schemas, config).
- **Verification**: Provide a post-upgrade checklist (Tests, manual checks, benchmarks, security advisories).

## Edge Cases
| Case | Strategy |
|------|----------|
| "Latest" requested | Identify latest stable; warn about major version jumps. |
| Peer conflicts | Resolve graph issues; recommend specific order or compatible set. |
| Security patch (CVE) | Prioritize fix; note CVE ID and additional config requirements. |

## Upgrade Flow
```mermaid
flowchart TD
    A([Start: current_dependencies + target_versions + tech_stack]) --> B{target_versions\nsays 'latest'?}
    B -- Yes --> C[Identify current latest stable versions\nCheck for major version jumps\nWarn about major version boundaries]
    B -- No --> D[Use specified target versions]
    C & D --> E{Security patch\ndriving upgrade?}
    E -- Yes --> F[Prioritize security fix\nNote CVE number and severity\nCheck if additional config changes needed]
    E -- No --> G
    F & G --> H[Breaking Change Analysis\nFor each dependency:\nVersion range being crossed\nBreaking changes in typical usage\nDeprecated APIs being removed\nNew required peer dependencies]
    H --> I{Peer dependency\nconflicts?}
    I -- Yes --> J[Identify conflict\nExplain dependency graph issue\nRecommend resolution order\nor compatible version combination]
    I -- No --> K
    J & K --> L[Impact Assessment per dependency\nHIGH: significant changes across multiple files\nMEDIUM: targeted changes in specific modules\nLOW: drop-in replacement, no code changes]
    L --> M[Step-by-Step Migration\nOrder dependencies: some must come before others\nExact commands to run\nCode changes required at each step\nVerification step after each major change]
    M --> N[Rollback Plan\nExact commands to restore previous versions\nNote: state that cannot be auto-rolled back\nDB migrations, config changes]
    N --> O[Post-Upgrade Checklist\nTests to run\nFunctionality to manually verify\nPerformance benchmarks to check\nSecurity advisories to review]
    O --> P([Output: Breaking changes + Impact assessment\n+ Migration steps + Rollback plan + Checklist])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
1. Is the solution the simplest possible?
2. Are failure modes (rollback) handled?
3. Does it scale to the dependency graph?
4. Are security implications (CVEs) addressed?
5. Is the outcome verified via tests?

## MCP Dependencies
- `@upstash/context7-mcp`: Library documentation and examples.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples to examples/, references to references/, added compatibility and license fields |
| 1.0.0 | 2026-03-20 | Initial release |
