---
name: boilerplate-generation
description: >
  Use to scaffold a new project from scratch — generating directory structure,
  configuration files, entry points, and a README skeleton. Activate when starting a new project,
  service, or package and needing a production-ready starting point.
  Do NOT use for adding features to existing projects, generating tests, or CI/CD configuration.
version: "1.1.0"
time_saved: "Manual: 2–4 hours | With skill: 10–20 minutes"
license: Proprietary — Personal Use Only
category: coding
complexity: Beginner
tokens: ~2500
tags: [boilerplate, scaffolding, project-setup, starter, configuration]
author: vheins
---

# Skill: Boilerplate Generation

## Purpose
Generate a production-ready project boilerplate including directory structure, config files, entry points, and README skeleton for any tech stack.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | Target stack (e.g., "Node.js + TypeScript + Express") |
| `project_type` | string | Yes | e.g., "REST API", "CLI tool", "npm library" |
| `features` | string | Yes | e.g., "auth, database, logging, Docker, testing" |

## Instructions
- **Directory Structure**: Provide a tree with purpose comments for each directory/key file.
- **Configuration**: Generate content for package managers, compilers, `.env.example`, and editor configs (`.gitignore`).
- **Entry Point**: Create a minimal working application with proper initialization order (Config → DB → Middleware → Routes).
- **README**: Include a skeleton covering description, prerequisites, setup, local run, and test commands.
- **Next Steps**: Provide a numbered list of 5 immediate post-setup recommendations.

## Edge Cases
| Case | Strategy |
|------|----------|
| Unusual project type | Generate closest standard boilerplate; note uncertainties. |
| Feature conflict | Flag conflict; ask for clarification or prioritize simplicity. |
| Minimal features | Generate essentials only; avoid unrequested complexity. |

## Workflow
```mermaid
flowchart TD
    A([Start: tech_stack + project_type + features]) --> B{features conflict?}
    B -- Yes --> C[Flag conflict\nask for clarification or pick simpler option]
    B -- No --> D{project_type known?}
    D -- Unusual type --> E[Generate closest standard boilerplate\nnote uncertainties]
    D -- Known type --> F[Generate directory tree\nwith purpose comments]
    E --> F
    F --> G[Generate config files\npkg manager + compiler + .env.example + .gitignore]
    G --> H{features empty?}
    H -- Yes --> I[Minimal boilerplate only\nno unrequested complexity]
    H -- No --> J[Add feature-specific config\nauth / DB / Docker / testing / logging]
    I --> K[Generate entry point\nminimal working app + init order]
    J --> K
    K --> L[Generate README skeleton\nprereqs + install + run + structure]
    L --> M[List 5 next steps\npost-setup recommendations]
    M --> N([Output: Directory tree\n+ Config files + Entry point\n+ README + Next steps])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
1. Is the solution the simplest possible?
2. Are failure modes handled?
3. Does it scale 10x in load/size?
4. Are security implications addressed?
5. is it testable and observable?

## MCP Dependencies
- `@upstash/context7-mcp`: Library documentation and examples.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples to examples/, references to references/, added compatibility and license fields |
| 1.0.0 | 2026-03-20 | Initial release |
