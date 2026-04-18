---
name: api-implementation
description: >
  Use to implement a REST or GraphQL API endpoint from a specification
  or description, including request validation, error handling, and accompanying tests.
  Activate for building a new API route, resolver, or handler end-to-end.
  Do NOT use for API design/contract creation, documentation generation, or frontend API consumption.
version: "1.1.0"
time_saved: "Manual: 3–6 hours | With skill: 20–40 minutes"
license: Proprietary — Personal Use Only
category: coding
complexity: Advanced
tokens: ~4000
tags: [api, rest, graphql, endpoint, validation, error-handling, testing]
author: vheins
---

# Skill: API Implementation

## Purpose
Implement a complete production-ready API endpoint (REST/GraphQL) from specification, including handler/resolver, validation, error handling, and tests.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | Target stack (e.g., "Node.js + Express + Zod") |
| `api_spec` | string | Yes | Method, path, schema, responses, rules |
| `context` | string | Yes | Project conventions, auth, models, error format |

## Instructions
- **Request Validation**: Use idiomatic tools (Zod, Pydantic, etc.). Return 400 on failure with field-level details.
- **Business Logic**: Keep handlers thin; delegate to service/repository layers.
- **Error Handling**: Map errors to standard codes (400, 401/403, 404, 409, 422, 500).
- **Testing**: Implement at least three cases: Happy path, Validation failure, and Resource not found/Conflict.
- **Documentation**: List assumptions and follow-up items (caching, rate limiting) after the code.

## Edge Cases
| Case | Strategy |
|------|----------|
| Underspecified spec | Implement common interpretation; list all assumptions. |
| Auth missing | Flag as security gap; add implementation comments. |
| Complex logic | Wrap in database transactions; ensure atomicity. |

## Refactoring Logic
```mermaid
flowchart TD
    A([Start: api_spec + tech_stack + context]) --> B{API type?}
    B -- REST --> C[Parse method + path + body schema]
    B -- GraphQL --> D[Parse resolver + input type + return type]
    C --> E[Implement request validation]
    D --> E
    E --> F{Validation passes?}
    F -- No --> G[Return 400 with field-level errors]
    F -- Yes --> H{Auth required?}
    H -- Not specified --> I[⚠️ Flag as security gap\nadd auth middleware comment]
    H -- Yes --> J{Auth valid?}
    J -- No --> K[Return 401 / 403]
    J -- Yes --> L[Delegate to service layer]
    I --> L
    L --> M{Business rule check}
    M -- Conflict/duplicate --> N[Return 409]
    M -- Rule violation --> O[Return 422]
    M -- Not found --> P[Return 404]
    M -- Pass --> Q{DB/external call}
    Q -- Error --> R[Log internally\nReturn 500 generic]
    Q -- Success --> S[Return 200/201 response]
    S --> T[Write tests:\nhappy path + 400 + 4xx]
    T --> U[List assumptions\n+ follow-up items]
    U --> V([Output: Handler + Tests\n+ Implementation Notes])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
1. Is the solution the simplest possible?
2. Are failure modes handled (4xx/5xx)?
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
