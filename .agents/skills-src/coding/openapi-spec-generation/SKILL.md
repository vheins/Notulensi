---
name: openapi-spec-generation
description: >
  Use to generate an OpenAPI 3.x YAML specification for an API, either
  from existing code or from a description. Activate for creating API
  documentation, generating client SDKs, or defining an API contract.
  Do NOT use for GraphQL schema generation, API implementation, or Postman collection creation.
version: "1.1.0"
time_saved: "Manual: 2–4 hours (writing YAML + schemas + examples) | With skill: 15–25 minutes"
license: Proprietary — Personal Use Only
category: coding
complexity: Intermediate
tokens: ~3000
tags: [openapi, swagger, api-documentation, yaml, api-contract, rest]
author: vheins
---

# Skill: OpenAPI Spec Generation

## Purpose
Generate complete OpenAPI 3.x YAML specifications from code or descriptions for SDK generation, documentation, and contract enforcement.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | e.g., "Node.js + Express" |
| `api_description` | string | Yes | Endpoints, request/response shapes, auth, errors |
| `context` | string | Yes | Version, base URL, audience, schema reuse |

## Instructions
- **Basics**: Define API info (title/version), server URLs (Dev/Staging/Prod), and contact details.
- **Security**: Implement schemes (JWT, API Key, OAuth2). Apply globally or per-operation.
- **Operations**: Document every endpoint with HTTP method, parameters (typed/validated), request body, and exhaustive response codes (200-500).
- **Components**: Extract reusable schemas for bodies, responses, parameters, and consistent error formats.
- **Examples**: Provide realistic data for request/success/error scenarios.
- **Validation**: Recommend linting with Spectral or Swagger Editor.

## Edge Cases
| Case | Strategy |
|------|----------|
| No existing docs | Infer behavior from code; flag inferred endpoints for review. |
| Polymorphism | Use `oneOf`/`anyOf` with discriminator fields. |
| File uploads | Use `multipart/form-data` with `format: binary`. |

## Generation Workflow
```mermaid
flowchart TD
    A([Start: OpenAPI Spec Generation]) --> B{Source of API description?}
    B -- Existing code --> C[Infer endpoints from routes/controllers, note inferred parts]
    B -- Written description --> D[Parse endpoints, methods, request/response shapes]
    C & D --> E[Define info: title, version, description, contact, license]
    E --> F[Define server URLs: dev / staging / prod]
    F --> G{Auth method?}
    G -- Bearer JWT --> H[Define BearerAuth security scheme]
    G -- API Key --> I[Define ApiKey security scheme]
    G -- OAuth2 --> J[Define OAuth2 flows]
    G -- Basic --> K[Define BasicAuth scheme]
    H & I & J & K --> L[Apply security globally or per-operation]
    L --> M[Define paths: for each endpoint add method, summary, tags]
    M --> N{Request has body?}
    N -- Yes --> O[Define requestBody schema with examples]
    N -- No --> P
    O --> P[Define parameters: path, query, header with types + validation]
    P --> Q[Define responses: 200/201 success + 400/401/403/404/422/500 errors]
    Q --> R{Polymorphic response?}
    R -- Yes --> S[Use oneOf / anyOf with discriminator]
    R -- No --> T
    S & T --> U{File upload endpoint?}
    U -- Yes --> V[Use multipart/form-data + format: binary]
    U -- No --> W
    V & W --> X[Extract reusable schemas to components/schemas]
    X --> Y[Add realistic examples for request + response + errors]
    Y --> Z[Validate with Swagger Editor / Spectral linter]
    Z --> AA([Output: Complete OpenAPI 3.x YAML spec])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
1. Is it valid YAML 3.x?
2. Are all 4xx/5xx responses defined?
3. Are security schemes applied?
4. Are schemas reused via components?
5. Is the spec linted/validated?

## MCP Dependencies
- `@upstash/context7-mcp`: Library documentation and examples.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples to examples/, references to references/, added compatibility and license fields |
| 1.0.0 | 2026-03-20 | Initial release |
