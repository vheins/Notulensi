---
name: environment-variable-misconfiguration
description: >
  Diagnoses and fixes missing, incorrect, or misloaded environment variables. Do NOT use for secrets management architecture, infrastructure provisioning, or CI/CD design.
version: "1.1.0"
time_saved: "5-15 minutes"
license: Proprietary — Personal Use Only
category: debugging
complexity: Intermediate
tokens: ~3500
tags: [environment-variables, dotenv, configuration, debugging, deployment]
author: vheins
---

# Skill: Environment Variable Misconfiguration

## Purpose
Identify and resolve missing, invalid, or improperly loaded environment variables in any stack.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | e.g., "Node.js + dotenv" |
| `error_message` | string | Yes | Error log |
| `env_file` | string | No | Redacted `.env` contents |
| `context` | string | Yes | Loading mechanism and env (Local/Prod) |

## Instructions
- **Identification**: Pinpoint issue (Missing var, wrong format, loading order, typo, prod/local gap).
- **Verification**: Check file path, loading timing, case-sensitivity, runtime injection, `.gitignore`.
- **Remediation**: Provide corrected `.env` and associated code changes.
- **Validation**: Implement fail-fast startup validation logic.
- **Best Practices**: Recommend `.env.example` and validation libraries (Zod/Envalid).
- **Fallback**: If no file, provide inspection commands and standard templates.

## Edge Cases
| Case | Strategy |
|------|----------|
| No file access | Provide inspection commands (`printenv`, `process.env` dump) and templates. |
| Format errors | Detect type requirements (JSON/URL/Port) and correct the value. |
| Loading precedence | Explain override order (e.g., Shell > `.env.local` > `.env`). |

## Diagnostic Workflow
```mermaid
flowchart TD
    A([Start]) --> B[Parse inputs]
    B --> C{.env available?}
    C -- No --> D[Provide inspection commands & template]
    C -- Yes --> F[Identify Misconfiguration]
    F --> G{Type?}
    G -- Missing --> H[Missing variable]
    G -- Wrong value --> I[Wrong format/env]
    G -- Loading order --> J[Loaded late]
    G -- Override --> K[Overrides failed]
    G -- Deployment gap --> L[Missing in prod]
    G -- Typo --> M[Typo]
    H & I & J & K & L & M --> N[Diagnostic Checklist]
    N --> O[Apply Fix]
    O --> P[Add Startup Validation]
    P --> Q[Add Best Practices]
    Q --> R([Output: Report])
    D --> S([Output: Limited diagnosis — inspect env & retry with .env file])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Fail-fast validation included.
- [ ] Loading order verified.
- [ ] Format (URL/Type) correct.
- [ ] Security (gitignore) checked.
- [ ] Fix is stack-specific.

## MCP Dependencies
- `@upstash/context7-mcp`: Library documentation and examples.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples/references, added fields |
| 1.0.0 | 2026-03-20 | Initial release |
