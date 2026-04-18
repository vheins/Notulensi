---
name: graphql-schema-generation
description: >
  Generate a GraphQL schema for a domain, including types, queries, mutations, subscriptions, directives, and resolvers.
  Do NOT use for REST API design, OpenAPI spec generation, or GraphQL client code generation.
version: "1.1.0"
time_saved: "Manual: 3–6 hours | With skill: 20–40 minutes"
license: Proprietary — Personal Use Only
category: coding
complexity: Advanced
tokens: ~4000
tags: [graphql, schema, types, resolvers, mutations, subscriptions, api-design]
author: vheins
---

# Skill: GraphQL Schema Generation

## Purpose
Generate complete, best-practice GraphQL schemas including SDL and resolver outlines.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | e.g., "Node.js + Apollo Server" |
| `domain_description` | string | Yes | Entities, relations, and business rules |
| `operations` | string | Yes | Required queries, mutations, subscriptions |

## Instructions
- **Types**: Define Object types (nullability), Input types (for mutations), Enums, and Unions. Use Connection types for pagination (Relay spec).
- **Queries**: Implement single lookup, paginated lists, and nested relations using descriptive names.
- **Mutations**: Return mutated payload objects with result/error unions. Add validation rules as comments.
- **Subscriptions**: Define triggers and filter arguments for real-time updates.
- **Resolvers**: Outline structure, identify N+1 risks (DataLoader), and define auth check placement.

## Edge Cases
| Case | Strategy |
|------|----------|
| Circular refs | Use lazy types; enforce resolver depth limits. |
| Large results | Enforce `first` arguments with maximum caps. |
| Field-level Auth | Apply `@auth` directives; specify field-level resolver placement. |

## Schema Flow
```mermaid
flowchart TD
    A([Start: GraphQL Schema Generation]) --> B{Schema source?}
    B -- Domain model --> C[Map entities → GraphQL types]
    B -- REST API --> D[Convert endpoints → queries/mutations]
    B -- Database schema --> E[Introspect tables → types + resolvers]
    C & D & E --> F[Define scalar types: ID, String, Int, DateTime, custom]
    F --> G[Model relationships: one-to-one, one-to-many, many-to-many]
    G --> H{Nullable vs non-null?}
    H --> I[Apply ! where field is always present]
    I --> J[Define Query type: list, single, filtered, paginated]
    J --> K{Mutations needed?}
    K -- Yes --> L[Define Mutation type: create, update, delete, batch]
    K -- No --> M
    L --> M{Subscriptions needed?}
    M -- Yes --> N[Define Subscription type for real-time events]
    M -- No --> O
    N & O --> P[Define input types for mutations]
    P --> Q{Auth/access control?}
    Q -- Yes --> R[Add directives: @auth, @deprecated, @skip, custom]
    Q -- No --> S
    R & S --> T{Pagination strategy?}
    T -- Cursor-based --> U[Add Connection/Edge/PageInfo types]
    T -- Offset-based --> V[Add limit/offset args]
    U & V --> W[Validate schema: no circular deps, no orphan types]
    W --> X[Generate SDL file + resolver stubs]
    X --> Y([Output: GraphQL schema + resolver scaffolding])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
1. Are inputs separate from objects?
2. Is pagination enforced on lists?
3. Are error unions included in mutations?
4. is nullability explicitly handled?
5. is the schema Relay-compliant?

## MCP Dependencies
- `@upstash/context7-mcp`: Library documentation and examples.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples/references, added compatibility/license |
| 1.0.0 | 2026-03-20 | Initial release |
