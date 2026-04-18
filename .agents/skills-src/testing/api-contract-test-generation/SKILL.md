---
name: api-contract-test-generation
description: >
  Generate contract tests verifying API implementations match OpenAPI specifications.
  Do NOT use for functional or performance tests.
version: "1.1.0"
time_saved: "Manual: 3-5 hours | With skill: 10-15 mins"
license: Proprietary — Personal Use Only
category: testing
complexity: Advanced
tokens: ~4000
tags: [contract-testing, openapi, api-testing, consumer-driven-contracts]
author: vheins
---

# Skill: API Contract Test Generation

## Purpose
Generate tests verifying API implementations match OpenAPI specs. Validates schemas, status codes, headers, and types to prevent contract breakage.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `api_spec` | string | Yes | OpenAPI spec (YAML/JSON) |
| `tech_stack` | string | Yes | e.g., "Node.js + Supertest" |
| `contract_type` | string | No | "provider" or "consumer" (default: provider) |

## Instructions
- **Response Validation**: Verify required fields, types (string/int), formats (uuid/date), and enums.
- **Status Codes**: Match exact spec codes for success (2xx) and error (4xx/5xx) paths.
- **Request Handling**: Enforce required fields and validate query/header constraints.
- **Headers**: Verify `Content-Type`, CORS, and authentication headers.
- **Schema Validation**: Use JSON Schema validation against the exact spec definition.
- **Backward Compatibility**: Ensure spec updates don't break existing consumers.

## Edge Cases
| Case | Strategy |
|------|----------|
| Spec Drift | Treat spec as the absolute source of truth. |
| Optional fields | Explicitly verify that optional fields do not cause failure when omitted. |
| Breaking changes | Flag backward-compatibility issues during generation. |

## Workflow
```mermaid
flowchart TD
    A([Start: API Contract Test Generation]) --> B[Parse inputs]
    B --> C{Contract type?}
    C -- provider --> D[Test API vs spec]
    C -- consumer --> E[Test API vs provider expectations]
    D & E --> F[Parse endpoints from spec]
    F --> G[Generate test cases per endpoint]
    G --> H[Validate Schemas]
    G --> I[Validate Status Codes]
    G --> J[Validate Request Handling]
    G --> K[Validate Headers]
    H & I & J & K --> L{Optional fields?}
    L -- Yes --> M[Verify truly optional]
    L -- No --> N
    M --> N{Spec updated?}
    N -- Yes --> O[Check backward compatibility]
    N -- No --> P
    O --> P[Generate all endpoint tests]
    P --> Q([Output: Complete Contract Test File])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Response schemas validated.
- [ ] Required fields enforced.
- [ ] Field types/formats validated.
- [ ] Error response schemas included.
- [ ] Undocumented fields detected.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples, references, added metadata |
| 1.0.0 | 2026-03-20 | Initial release |
