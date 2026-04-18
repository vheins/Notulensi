--- 
name: api-contract-design
description: >
  Designs REST/GraphQL API contracts with endpoint definitions, schemas, error codes, auth requirements, and rate limiting.
  Do NOT use for API implementation, OpenAPI generation, or DB schema design.
version: "1.2.0"
time_saved: "Manual: 3–6 hours | With skill: 20–40 minutes"
license: Proprietary — Personal Use Only
category: planning
complexity: Advanced
tokens: ~5000
tags: [api-design, REST, GraphQL, JSON:API, contract, endpoints, schema, error-codes]
author: vheins
---

# Skill: API Contract Design

## Purpose
Produce an authoritative API contract (REST or GraphQL) for a resource/domain. Default response format is JSON:API v1.1.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `api_type` | string | Yes | REST or GraphQL |
| `resource_name` | string | Yes | e.g., "Order" |
| `operations` | string | Yes | e.g., "CRUD + cancel" |
| `tech_stack` | string | Yes | Backend stack |
| `response_format`| string | No | jsonapi (default) or custom |

## Instructions
- **Endpoints/Schema**: Define REST paths (plural nouns, versioned `/api/v1/`) or GraphQL types/mutations.
- **Validation**: Provide a table mapping fields to rules (e.g., `min:3`, `unique`) and exact error messages.
- **JSON:API**: If using default, use `application/vnd.api+json`, string IDs, and `data`/`errors` separation.
- **Examples**: Provide full JSON request/response snippets for every operation using realistic domain data.
- **Error Dictionary**: Map codes (e.g., `USER_EMAIL_TAKEN`) to HTTP statuses (401, 403, 404, 409, 422, 429, 500).
- **Auth**: Specify method (Bearer JWT), endpoint access levels, and token placement.
- **Rate Limiting**: Define scope (per user/IP), limits (req/min), and 429 `Retry-After` behavior.

## Edge Cases
| Case | Strategy |
|------|----------|
| Ambiguous Ops | Stop and ask for specific CRUD operations rather than assuming. |
| REST vs GQL | Recommend GraphQL if the requirements involve complex nested relationships. |
| Versioning | Always include an `/api/v1/` prefix for REST unless explicitly told otherwise. |

## Workflow
```mermaid
flowchart TD
    A([Start: API Contract Request]) --> B{response_format?}
    B -- jsonapi default --> C[Use application/vnd.api+json]
    B -- custom --> D[Use custom envelope]
    C & D --> E{api_type?}
    E -- REST --> F[List endpoints (method, path, params)]
    E -- GraphQL --> G[Define types, queries, mutations]
    F & G --> H{operations\namibiguous?}
    H -- Yes --> I[Ask for specific CRUD operations]
    I --> H
    H -- No --> J[Build Validation Table]
    J --> K[Write Request + Response Examples\nRealistic data]
    K --> L[Build Error Dictionary\nSpecific codes]
    L --> M[Specify Authentication Requirements]
    M --> N[Write Rate Limiting Notes]
    N --> O{Versioning\naddressed?}
    O -- No --> P[Add /api/v1/ prefix]
    O -- Yes --> Q([Output: 6-section API contract])
    P --> Q
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] JSON:API v1.1 standards followed (if default).
- [ ] Full JSON examples provided.
- [ ] Validation rules/messages explicit.
- [ ] Error dictionary is comprehensive.
- [ ] Auth and rate limits specified.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.2.0 | 2026-03-22 | JSON:API v1.1 as default format. |
| 1.1.0 | 2026-03-21 | Added Validation Table, JSON examples, Error Dictionary. |
| 1.0.0 | 2026-03-20 | Initial release |
