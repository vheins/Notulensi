---
name: pagination-implementation
description: >
  Use to implement pagination for an API endpoint or UI data list.
  Activate for cursor-based or offset pagination, total count, next/prev
  links, and performance considerations for large datasets.
  Do NOT use for infinite scroll UI implementation, search result ranking, or data filtering design.
version: "1.1.0"
time_saved: "Manual: 1–3 hours (strategy selection + implementation + edge cases) | With skill: 10–20 minutes"
license: Proprietary — Personal Use Only
category: coding
complexity: Intermediate
tokens: ~3000
tags: [pagination, cursor-based, offset, api, performance, large-datasets]
author: vheins
---

# Skill: Pagination Implementation

## Purpose
Implement efficient backend pagination (Cursor or Offset) with navigation metadata and performance optimization.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | e.g., "Node.js + Prisma" |
| `api_or_ui` | string | Yes | Target: REST, GraphQL, or UI list |
| `data_model` | string | Yes | Table name, sort/filter fields, row count |

## Instructions
- **Strategy Selection**: Choose Offset (random access, simple) vs. Cursor (consistent, scales better) based on dataset size and mutation frequency.
- **Backend Implementation**: Validate parameters. Execute query with `LIMIT/OFFSET` or `WHERE` keyset. count records efficiently (avoid full counts on large tables).
- **Response Schema**: 
  - REST: `{ data, total, page, limit, hasNext, hasPrev }`
  - Cursor: `{ data, nextCursor, prevCursor, hasMore }`
  - GraphQL: Connection/Edges/PageInfo.
- **Performance**: Require indexes on sort/filter columns. Use estimated or cached counts for large datasets.
- **Client Usage**: Provide an example of iterative fetching.

## Edge Cases
| Case | Strategy |
|------|----------|
| Non-unique Sort | Add secondary `id` sort to ensure stable ordering. |
| Filter + Pagination | Encode filter state in cursor or use keyset-compatible filters. |
| High Row Count | Use `pg_stat` estimates or cached counters instead of `COUNT(*)`. |

## Pagination Logic
```mermaid
flowchart TD
    A([Start: Pagination Implementation]) --> B[Analyze data model: size, sort fields, filter fields]
    B --> C{Dataset size + use case?}
    C -- Small / random page access needed --> D[Offset pagination: LIMIT + OFFSET]
    C -- Large / real-time / consistent --> E[Cursor-based: keyset WHERE clause]
    D --> F[Parse + validate: page, limit params with max cap]
    E --> G[Parse + validate: cursor, limit params; decode cursor]
    F --> H[Execute query: SELECT ... LIMIT limit OFFSET page*limit]
    G --> I[Execute query: SELECT ... WHERE id > cursor LIMIT limit+1]
    H & I --> J{Need total count?}
    J -- Yes, small table --> K[COUNT* query]
    J -- Yes, large table --> L[Estimated count from pg_stat or cached counter]
    J -- No --> M[Skip count, return hasMore only]
    K & L & M --> N{Sort column unique?}
    N -- No --> O[Add secondary sort on id for stable ordering]
    N -- Yes --> P
    O & P --> Q{Filtering + pagination?}
    Q -- Yes --> R[Encode filter state in cursor or use keyset with filter]
    Q -- No --> S
    R & S --> T[Build response: data + pagination metadata]
    T --> U{API type?}
    U -- REST --> V[Return: data, total, page, limit, hasNext, hasPrev]
    U -- Cursor REST --> W[Return: data, nextCursor, prevCursor, hasMore]
    U -- GraphQL --> X[Return: Connection with edges, pageInfo, totalCount]
    V & W & X --> Y[Add index on sort + filter columns]
    Y --> Z([Output: Paginated endpoint with performance notes])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
1. Is the strategy justified by scale?
2. Are sort columns indexed?
3. Is ordering stable?
4. Are large counts handled efficiently?
5. is the response schema standard?

## MCP Dependencies
- `@upstash/context7-mcp`: Library documentation and examples.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples to examples/, references to references/, added compatibility and license fields |
| 1.0.0 | 2026-03-20 | Initial release |
