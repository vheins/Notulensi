---
name: tech-stack-guidelines
description: Provides architectural guidelines, coding standards, folder structure, and best practices for 13 supported tech stacks. DO NOT use for generating actual code.
version: "1.1.0"
time_saved: "Manual: 2–4 hours | With skill: 10–15 minutes"
license: Proprietary — Personal Use Only
category: coding
complexity: Intermediate
tokens: ~2500
tags: [tech-stack, architecture, best-practices, coding-standards, folder-structure, guidelines]
author: vheins
---

# Skill: Tech Stack Guidelines

## Purpose
Provide architectural blueprints, folder structures, and standards for any of the 14 supported tech stacks to ensure project alignment.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | Target stack (see list) |
| `context` | string | No | Focus: e.g., "auth", "folder structure" |

## Supported Stacks
- `laravel` (Modular Monolith)
- `laravel-filament` (ERP/Admin)
- `vuejs`, `react`, `nextjs`, `nuxtjs`
- `flutter` (GetX)
- `express`, `fastapi`, `golang` (Clean Arch)
- `rust` (Axum/Actix)
- `spring-boot`, `dotnet` (Clean Arch)
- `odoo` (ERP Platform)

## Instructions
- **Overview**: Define core tech versions, architectural patterns, and design rationale.
- **Structure**: Provide a recommended directory tree with purpose documentation.
- **Standards**: Detail language rules (typing, async), naming (files, variables), and pattern usage.
- **Tooling**: List essential dependencies, test frameworks, and lint/fmt tools.
- **Checklist**: Provide a validation list (Folder, Naming, Error Handling, Tests, Anti-patterns).
- **Scope**: Focus output on `{{context}}` if specified.

## Edge Cases
| Case | Strategy |
|------|----------|
| Conflicts | Recommend closest compatible alternative; flag the tension. |
| Unfamiliar Stack | Apply general principles; explicitly note it is an untested blueprint. |
| Monolith vs Micro | Default to Monolith for teams <10 or <50k DAU. |

## Guideline Logic
```mermaid
flowchart TD
    A([Start: Tech Stack Guidelines]) --> B{Stack in supported list?}
    B -- Yes --> C[Load reference guidelines for stack]
    B -- No --> D[Apply general principles, note output is not a tested blueprint]
    C & D --> E{Context provided?}
    E -- Yes --> F[Focus output on relevant area: auth, folder structure, etc.]
    E -- No --> G[Provide full guidelines]
    F & G --> H[Stack Overview: core tech, versions, architecture pattern]
    H --> I[Folder Structure: directory tree + purpose of each dir]
    I --> J[Coding Standards: naming, typing, async, error handling, anti-patterns]
    J --> K[Key Libraries & Tools: deps, testing framework, linting]
    K --> L{Scale requirements conflict with stack?}
    L -- Yes --> M[Flag conflict, recommend closest compatible alternative]
    L -- No --> N
    M & N --> O{Monolith vs microservices ambiguous?}
    O -- Yes --> P[Default to monolith if team < 10 or traffic < 50k DAU, explain decision]
    O -- No --> Q
    P & Q --> R[Implementation Checklist: folder, naming, error handling, tests, anti-patterns]
    R --> S{Migration path needed?}
    S -- Yes --> T[Document migration path if requirements change]
    S -- No --> U
    T & U --> V([Output: Stack reference guide with checklist])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
1. Matches the chosen stack?
2. Is the folder tree clear?
3. are anti-patterns listed?
4. is the checklist actionable?
5. Is scale considered?

## MCP Dependencies
- `@upstash/context7-mcp`: Library documentation and examples.
- `@modelcontextprotocol/server-sequential-thinking`: Complex reasoning.
- `@modelcontextprotocol/server-memory`: Knowledge graph.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.0.0 | 2026-03-20 | Initial release — 14 stacks included |
