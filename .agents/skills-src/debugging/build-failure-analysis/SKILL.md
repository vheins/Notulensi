---
name: build-failure-analysis
description: >
  Analyze build failures to identify root causes and provide fix instructions. Do not use for deployment failures or runtime errors.
version: "1.1.0"
time_saved: "Manual: 30–90 minutes | With skill: 5–15 minutes"
license: Proprietary — Personal Use Only
category: debugging
complexity: Intermediate
tokens: ~3000
tags: [build, compilation, bundler, ci, debugging]
author: vheins
---

# Skill: Build Failure Analysis

## Purpose
Identify root causes of build/compilation failures and provide exact fix steps and clean build procedures.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | Build tool and language |
| `build_output` | string | Yes | Full error logs |
| `context` | string | Yes | Recent changes (code, deps, CI) |

## Instructions
- **Classification**: Identify failure type (Compilation, Missing dependency, Config, Environment, OOM, Circularity).
- **Identification**: Pinpoint exact file, line, and message; ignore cascading artifacts.
- **Remediation**: Provide numbered, actionable steps with exact code/config changes.
- **Cleaning**: Provide shell commands for clean build sequence (e.g., `rm -rf node_modules && install`).
- **CI/CD**: Identify environment differences (version, case sensitivity) for CI-only failures.
- **Fallback**: If no output, provide verbose build commands and common-failure checklist.

## Edge Cases
| Case | Strategy |
|------|----------|
| No Logs | Provide verbose commands; list common causes/diagnostics. |
| CI vs Local | Check version diffs, env vars, and case-sensitive pathing. |
| OOM | Provide memory config (JVM/Node) or incremental build steps. |

## Analysis Logic
```mermaid
flowchart TD
    A([Start: Build Failure Analysis]) --> B[Parse tech_stack, build_output, context]
    B --> C{Build output available?}
    C -- No --> D[Provide verbose build command]
    D --> E[List common failure causes]
    E --> F[Suggest clean build procedure]
    C -- Yes --> G[Classify Build Failure Type]
    G --> H{Failure type?}
    H -- Compilation --> I[Identify root file/line, ignore cascading]
    H -- Missing dep --> J[Check package install, verify resolution]
    H -- Config --> K[Validate config syntax]
    H -- Environment --> L[Check runtime version/tools]
    H -- OOM --> M[Increase heap size / chunk build]
    H -- Circular dep --> N[Map import cycle, break reference]
    I & J & K & L & M & N --> O[Provide exact fix steps]
    O --> P{Fails in CI only?}
    P -- Yes --> Q[Identify env diff, fix both]
    P -- No --> R[Provide clean build sequence]
    Q --> R
    R --> S([Output: 5-Section Report])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Root cause identified.
- [ ] Fix steps actionable.
- [ ] Clean build documented.
- [ ] Environment diffs addressed.
- [ ] Tool version checked.

## MCP Dependencies
- `@upstash/context7-mcp`: Library documentation and examples.
- `@modelcontextprotocol/server-sequential-thinking`: Complex reasoning.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: examples/references separated, added fields |
| 1.0.0 | 2026-03-20 | Initial release |
