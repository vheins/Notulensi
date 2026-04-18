---
name: environment-setup
description: >
  Use to generate environment setup scripts, .env.example files, and
  README setup documentation for a project. Activate when onboarding a new developer or setting
  up a project for the first time on a new machine.
  Do NOT use for CI/CD pipeline configuration, Docker setup, or production infrastructure setup.
version: "1.1.0"
time_saved: "Manual: 1–2 hours | With skill: 10–15 minutes"
license: Proprietary — Personal Use Only
category: coding
complexity: Beginner
tokens: ~3000
tags: [environment-setup, onboarding, dotenv, setup-scripts, developer-experience]
author: vheins
---

# Skill: Environment Setup

## Purpose
Generate zero-friction onboarding materials including setup scripts, documented `.env.example`, and verification steps to get projects running in <10 minutes.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | e.g., "Node.js + PostgreSQL + Redis" |
| `project_description` | string | Yes | project purpose and main components |
| `os_target` | string | Yes | e.g., "macOS + Linux", "all platforms" |

## Instructions
- **Prerequisites**: List required tools with versions and install commands (per OS).
- **Setup Script**: Generate an idempotent shell script (or equivalent) that installs dependencies, runs DB migrations, copies `.env.example`, and performs a basic health check.
- **`.env.example`**: Document every variable with inline comments, safe local examples, and "CHANGE_ME" markers.
- **README**: Provide numbered "Getting Started" steps with expected outputs and common error fixes.
- **Verification**: Include a checklist for DB/cache connectivity, test suite runs, and server responsiveness.

## Edge Cases
| Case | Strategy |
|------|----------|
| Windows (no WSL) | Generate PowerShell scripts; note path/newline gotchas. |
| Docker-based | Provide `docker-compose up` as primary; manual as fallback. |
| 3rd-Party services | Include sandbox credentials/links in `.env.example`. |

## Setup Workflow
```mermaid
flowchart TD
    A([Start: tech_stack + project_description + os_target]) --> B{Windows w/o WSL?}
    B -- Yes --> C[Generate PowerShell + Bash scripts]
    B -- No --> D
    C & D --> E{Use Docker?}
    E -- Yes --> F[docker-compose as primary\nmanual fallback]
    E -- No --> G[Manual setup as primary]
    F & G --> H[Prerequisites List\nTools + Versions + Install per OS]
    H --> I[Setup Script\nIdempotent + DB setup + Env copy + Health check]
    I --> J{External deps?}
    J -- Yes --> K[Include sandbox creds in .env.example]
    J -- No --> L
    K & L --> M[.env.example\nVars + Comments + Local examples + Markers]
    M --> N[README Setup Section\nSteps + Expected output + Troubleshooting]
    N --> O[Verification Steps\nService checks + Tests + Server check]
    O --> P([Output: Prerequisites + Setup script\n+ .env.example + README + Verification])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
1. Is the setup script idempotent?
2. Are all required variables documented?
3. Are OS-specific install commands included?
4. Is there a clear verification path?
5. is the README section concise?

## MCP Dependencies
- `@upstash/context7-mcp`: Library documentation and examples.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples to examples/, references to references/, added compatibility and license fields |
| 1.0.0 | 2026-03-20 | Initial release |
