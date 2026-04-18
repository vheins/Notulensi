---
name: api-documentation
description: >
  Generate OpenAPI-compatible documentation for REST API endpoints (schemas, auth, parameters, error codes).
  Do NOT use for GraphQL, SDK reference docs, or architecture documentation.
version: "1.1.0"
time_saved: "Manual: 3-4 hours | With skill: 10-15 minutes"
license: Proprietary — Personal Use Only
category: documentation
complexity: Intermediate
tokens: ~4500
tags: [api-documentation, openapi, rest, request-response-schema, endpoints]
author: vheins
---

# Agent Optimized: API Documentation

## Directives
- **Source Analysis**: Use `{{existing_code}}` to derive schemas; otherwise, infer from `{{endpoint_description}}`.
- **Content Sections**:
    - **Overview**: Method, path, summary, side effects.
    - **Auth**: Requirement, mechanism, location, scopes. Default to "Bearer JWT".
    - **Params**: Tables for Path and Query params (Name, Type, Req, Default, Desc, Example).
    - **Body**: Content type, JSON Schema (fields, types, validation).
    - **Responses**: Success (2xx) and Error (4xx/5xx) schemas + examples.
    - **Usage**: Runnable `curl` command + success body.
    - **OpenAPI**: Valid OpenAPI 3.0 YAML snippet.
- **Precision**: Use realistic example values. Preserved version prefixes in paths.

## Logic Flow
```mermaid
flowchart TD
    A([Start]) --> B{Code Provided?}
    B -- Yes --> C[Derive schema from code]
    B -- No --> D[Infer schema from desc]
    C & D --> E[Define Auth mechanism]
    E --> F[Document Params: Path/Query]
    F --> G{Req Body?}
    G -- Yes --> H[Body Schema: JSON]
    G -- No --> I[Skip Body]
    H & I --> J[Define Responses: Success/Error]
    J --> K[Draft curl example]
    K --> L[Generate YAML snippet]
    L --> M([Final API Doc])
```

## Constraints
| Rule | Description |
|------|-------------|
| Formatting | Use 8 standard headers (`##`); Tables for all schemas. |
| YAML | Snip must be valid OpenAPI 3.0; include `security` definitions. |
| File Uploads | Use `multipart/form-data` and document metadata fields. |
| Multi-Success | Document each distinct success response variant separately. |

## Review Criteria
- [ ] Error response codes have realistic examples.
- [ ] YAML snippet passes validation.
- [ ] Parameter constraints (min/max, regex) are captured.
- [ ] `curl` example uses valid CLI syntax.

## Metadata
- **Output Path**: `.agents/documents/application/api/{module-slug}/`
- **Changelog**: 1.1.0 (Refined content sections, added metadata); 1.0.0 (Initial).
