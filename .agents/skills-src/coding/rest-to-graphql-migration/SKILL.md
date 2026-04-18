---
name: rest-to-graphql-migration
description: >
  Use to plan and implement a migration from a REST API to GraphQL,
  including schema design, resolver mapping, deprecation strategy, and client migration guide.
  Activate for transitioning an existing REST API to GraphQL.
  Do NOT use for designing a new GraphQL API from scratch, REST API design, or API versioning.
version: "1.1.0"
time_saved: "Manual: 4–8 hours (mapping + schema + resolvers + migration guide) | With skill: 30–60 minutes"
license: Proprietary — Personal Use Only
category: coding
complexity: Advanced
tokens: ~4500
tags: [graphql, rest, migration, schema-design, deprecation, api-evolution]
author: vheins
---

# Skill: REST to GraphQL Migration

## Purpose
Plan and implement an incremental migration from REST to GraphQL, including schema design, resolver logic sharing, and client transition guides.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | e.g., "Express -> Apollo" |
| `rest_api_spec` | string | Yes | Endpoints, schemas, and auth methods |
| `migration_scope` | string | Yes | Full, resource-group, or Strangler Fig |

## Instructions
- **Mapping**: Map REST methods to GraphQL operations (GET -> Query; POST/PUT/DELETE -> Mutations). Convert nested resources to nested types with resolvers.
- **Schema**: Design types mirrored from REST response shapes. Consolidate endpoints and add Connections for pagination.
- **Resolvers**: Implement resolvers that call existing service/repository layers to prevent logic duplication.
- **Coexistence**: Keep REST active with deprecation notices. Recommend a sunset timeline.
- **Migration Guide**: Provide before/after examples. Document auth handling (Headers) and error mapping (Status Codes -> GraphQL Errors).

## Edge Cases
| Case | Strategy |
|------|----------|
| Side-effect GETs | Flag as anti-patterns; map to Mutations in GraphQL. |
| File Uploads | Use Multipart Request spec; note client config requirements. |
| Batch Endpoints | Map to list mutations or use DataLoader for resolver-level batching. |

## Migration Flow
```mermaid
flowchart TD
    A([Start: REST to GraphQL Migration]) --> B[Inventory all REST endpoints]
    B --> C{Migration scope?}
    C -- Full migration --> D[Map all endpoints to GraphQL operations]
    C -- Specific resource group --> E[Map only target resource endpoints]
    C -- Strangler fig --> F[Wrap REST behind GraphQL layer incrementally]
    D & E & F --> G[Map HTTP methods to GraphQL operations]
    G --> H[GET → Query]
    G --> I[POST → Mutation create]
    G --> J[PUT/PATCH → Mutation update]
    G --> K[DELETE → Mutation delete]
    G --> L[Nested resources → nested types with resolvers]
    H & I & J & K & L --> M{GET with side effects found?}
    M -- Yes --> N[Flag as anti-pattern, map to Mutation, note client impact]
    M -- No --> O
    N & O --> P[Design GraphQL schema from data model]
    P --> Q{Paginated endpoints?}
    Q -- Yes --> R[Add Connection / Edge / PageInfo types]
    Q -- No --> S
    R & S --> T{File upload endpoints?}
    T -- Yes --> U[Use multipart request spec + note client config needed]
    T -- No --> V
    U & V --> W[Implement resolvers reusing existing service/repo layer]
    W --> X[Keep REST endpoints active during transition]
    X --> Y[Add deprecation notices to REST endpoints]
    Y --> Z[Write client migration guide: before/after per endpoint]
    Z --> AA[Define sunset timeline for REST endpoints]
    AA --> AB([Output: GraphQL schema + resolvers + coexistence strategy])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
1. Is logic shared with existing REST?
2. Is the schema Relay/Connection compliant?
3. Is auth consistency maintained?
4. Is there a clear client upgrade path?
5. is the coexistence strategy zero-downtime?

## MCP Dependencies
- `@upstash/context7-mcp`: Library documentation and examples.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples to examples/, references to references/, added compatibility and license fields |
| 1.0.0 | 2026-03-20 | Initial release |
