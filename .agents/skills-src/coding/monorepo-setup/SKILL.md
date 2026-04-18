---
name: monorepo-setup
description: >
  Use to configure a monorepo with workspace tooling, shared packages,
  build pipeline, and CI optimization. Activate for setting up Turborepo,
  Nx, Lerna, or similar monorepo tooling for a multi-package project.
  Do NOT use for single-package project setup, CI/CD pipeline scripting, or Docker configuration.
version: "1.1.0"
time_saved: "Manual: 4–8 hours (tooling research + configuration + shared package setup) | With skill: 30–60 minutes"
license: Proprietary — Personal Use Only
category: coding
complexity: Advanced
tokens: ~4500
tags: [monorepo, turborepo, nx, lerna, workspace, build-pipeline, shared-packages]
author: vheins
---

# Skill: Monorepo Setup

## Purpose
Configure a scalable monorepo with efficient code sharing, cached build pipelines, and CI optimizations using Turborepo, Nx, or Lerna.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | e.g., "TypeScript + Node.js" |
| `packages` | string | Yes | List of apps and shared libraries |
| `tooling` | string | Yes | e.g., "Turborepo", "Nx", "pnpm workspaces" |

## Instructions
- **Structure**: Organize into `apps/` (deployables) and `packages/` (shared libs). Define clear purposes and dependency paths.
- **Root Config**: Generate workspace settings (`package.json`, `pnpm-workspace.yaml`), tool configs (`turbo.json`, `nx.json`), and shared lint/style rules.
- **Shared Packages**: Configure ESM/CJS compatibility via `exports`, root-extending `tsconfig.json`, and standardized build outputs (`dist/`).
- **Pipeline**: Map the task dependency graph. Configure caching (keys/outputs), parallel execution, and watch modes.
- **CI**: Implement affected-only builds. Set up remote caching (Turborepo Remote Cache / Nx Cloud) and estimate time savings.

## Edge Cases
| Case | Strategy |
|------|----------|
| Mixed Languages | Configure tool per-language; note cross-language limitations. |
| NPM Publishing | Add `changesets` for versioning; distinguish private vs. public packages. |
| Large Scale (50+) | Recommend Nx; configure granular caching and affected-only CI immediately. |

## Workflow
```mermaid
flowchart TD
    A([Start: Monorepo Setup]) --> B{Tooling choice?}
    B -- Turborepo --> C[Init turbo.json + pipeline task graph]
    B -- Nx --> D[Init nx.json + project graph]
    B -- Lerna + npm workspaces --> E[Init lerna.json + workspaces in root package.json]
    B -- pnpm workspaces --> F[Init pnpm-workspace.yaml]
    C & D & E & F --> G[Define directory structure: apps/ + packages/]
    G --> H[Configure root tsconfig.json with path aliases]
    H --> I[Configure shared ESLint + Prettier at root]
    I --> J{Package count > 50?}
    J -- Yes --> K[Prefer Nx: better project graph + granular caching]
    J -- No --> L[Turborepo sufficient]
    K & L --> M[Set up shared package: exports field, ESM/CJS compat]
    M --> N[Configure build pipeline: task dependency graph]
    N --> O{Remote caching?}
    O -- Turborepo --> P[Configure Turborepo Remote Cache]
    O -- Nx --> Q[Configure Nx Cloud]
    O -- None --> R[Local cache only — flag for team]
    P & Q & R --> S[Configure affected-only builds for CI]
    S --> T{Publishing packages to npm?}
    T -- Yes --> U[Add changesets for versioning + publishing]
    T -- No --> V[Private workspace packages only]
    U & V --> W[Validate: build one package, check cache hit on rebuild]
    W --> X([Output: Monorepo with caching, shared packages, CI optimization])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
1. Build only what changed?
2. Is code shared efficiently?
3. Are root configs consolidated?
4. Is CI optimized (affected)?
5. is the dependency graph valid?

## MCP Dependencies
- `@upstash/context7-mcp`: Library documentation and examples.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples to examples/, references to references/, added compatibility and license fields |
| 1.0.0 | 2026-03-20 | Initial release |
