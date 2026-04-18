---
name: cors-error-resolution
description: >
  Resolves browser CORS errors by identifying missing headers and applying server-side fixes.
  Do NOT use for authentication errors, API gateway config, or network firewalls.
version: "1.1.0"
time_saved: "Manual: 30-90m | With skill: 5-15m"
license: Proprietary — Personal Use Only
category: debugging
complexity: Intermediate
tokens: ~3500
tags: [cors, cross-origin, headers, browser, debugging, http]
author: vheins
---

# Skill: CORS Error Resolution

## Purpose
Diagnose browser CORS violations and provide server-side configuration fixes for headers and preflight handling.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | e.g., "Node.js + Express" |
| `error_message` | string | Yes | Full browser error message |
| `request_details` | string | Yes | Method, URL, headers, and origin |
| `server_config` | string | No | Current middleware/config |

## Instructions
- **Classification**: Identify violation (Missing `Allow-Origin`, mismatch, preflight unhandled, invalid wildcard).
- **Analysis**: Determine request type (Simple, Preflight/OPTIONS, or Credentialed).
- **Remediation**:
  - Implement correct `Access-Control-Allow-*` headers.
  - Handle OPTIONS with 204 status.
  - Replace `*` with specific origins if credentials required.
- **Security**: Validate origins against whitelist; use `Vary: Origin`.
- **Validation**: Provide `curl -v -X OPTIONS` command to verify headers.
- **Fallback**: If no config, identify likely missing headers and provide stack templates.

## Edge Cases
| Case | Strategy |
|------|----------|
| No Config | Identify header from error; provide standard middleware snippet. |
| Same-Origin mismatch | Check for port, protocol, or subdomain discrepancies. |
| Reverse Proxy | Ensure proxy doesn't strip headers; add passthrough config. |

## Diagnostic Flow
```mermaid
flowchart TD
    A([Start: CORS Error Resolution]) --> B[Parse inputs]
    B --> C{Config available?}
    C -- No --> D[Identify missing header
Provide standard config]
    C -- Yes --> E[Classify Violation]
    E --> F{Request type?}
    F -- Simple --> G[No preflight]
    F -- Preflight --> H[Needs OPTIONS handler]
    F -- Credentialed --> I[Requires specific origin]
    G & H & I --> J{Violation?}
    J -- Missing Allow-Origin --> K[Set Allow-Origin]
    J -- Missing Allow-Methods --> L[Set Allow-Methods]
    J -- Missing Allow-Headers --> M[Set Allow-Headers]
    J -- Wildcard+credentials --> N[Replace * with specific origin]
    J -- Preflight unhandled --> O[Add OPTIONS route 204]
    K & L & M & N & O --> P[Write complete config]
    P --> Q[Security check:
Validate Origin
Set Vary: Origin]
    Q --> R{Behind proxy?}
    R -- Yes --> S[Check proxy strips headers
Add passthrough]
    R -- No --> T
    S --> T[Provide curl test]
    T --> U([Output: 5 Sections + Config + Test])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Violation correctly identified.
- [ ] Credential rules followed (no `*`).
- [ ] OPTIONS handler included.
- [ ] Security risks flagged.
- [ ] Test command accurate.

## MCP Dependencies
- `@upstash/context7-mcp`: Library documentation and examples.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples, references, added compatibility/license |
| 1.0.0 | 2026-03-20 | Initial release |
