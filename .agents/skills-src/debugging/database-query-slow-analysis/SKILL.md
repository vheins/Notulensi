---
name: database-query-slow-analysis
description: >
  Interprets EXPLAIN/EXPLAIN ANALYZE output to diagnose slow queries and recommend indexes or rewrites. Do NOT use for schema design or ORM configuration.
version: "1.1.0"
time_saved: "20-40 minutes"
license: Proprietary — Personal Use Only
category: debugging
complexity: Advanced
tokens: ~5000
tags: [database, slow-query, explain, index, query-optimization, debugging]
author: vheins
---

# Skill: Database Query Slow Analysis

## Purpose
Analyze slow SQL queries using EXPLAIN data to identify missing indexes, inefficient joins, or stale statistics, providing exact fixes and maintenance steps.

## Input
| Variable | Type | Req | Description |
|----------|------|----------|-------------|
| `tech_stack` | string | Yes | DB + ORM (e.g., "Postgres + Prisma") |
| `slow_query` | string | Yes | SQL query text |
| `explain_output` | string | No | EXPLAIN / ANALYZE logs |
| `schema` | string | Yes | Table/Index definitions |

## Instructions
- **Plan Analysis**: Identify scan types (Seq vs Index), join strategies, and row count discrepancies (Stale stats).
- **Problem Identification**: Pinpoint sequential scans, missing covering indexes, or inefficient join orders.
- **Indexing**: Write exact `CREATE INDEX` statements; explain accelerated paths and estimated gain.
- **Optimization**: Provide rewritten SQL (Replace correlated subqueries, use UNION ALL, add hints).
- **Maintenance**: Recommend `ANALYZE/VACUUM` and checks for `pg_stat_user_tables`.
- **Fallback**: If no EXPLAIN, analyze structure for anti-patterns and provide `EXPLAIN ANALYZE` commands.

## Edge Cases
| Case | Strategy |
|------|----------|
| No EXPLAIN | Analyze query structure and schema; estimate cost based on size. |
| Indexes Ignored | Check for bloat, lock contention, or stale stats; recommend `BUFFERS`. |
| ORM patterns | Identify N+1 or missing eager loads; provide ORM-level code fixes. |

## Analysis Logic
```mermaid
flowchart TD
    A([Start]) --> B[Parse inputs]
    B --> C{EXPLAIN available?}
    C -- No --> D[Analyze structure for anti-patterns]
    C -- Yes --> G[Parse EXPLAIN output]
    D --> E[Identify columns to index]
    E --> F[Provide EXPLAIN ANALYZE command]
    G --> H[Identify scan types]
    H --> I[Identify join strategies]
    I --> J{Row count mismatch?}
    J -- Large discrepancy --> K[Stale stats]
    J -- OK --> L[List performance problems]
    K --> L
    L --> M[Write CREATE INDEX statements]
    M --> N{Query suboptimal?}
    N -- Yes --> O[Rewrite query]
    N -- No --> P{ORM-generated?}
    O --> P
    P -- Yes --> Q[Identify ORM pattern]
    P -- No --> R[Recommend maintenance]
    Q --> R
    R --> S([Output: Report])
    F --> T([Output: Alternative diagnosis — structure-based recommendations])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Scan types correctly identified.
- [ ] Row estimate gaps highlighted.
- [ ] SQL rewrite is syntactically correct.
- [ ] Maintenance steps included.
- [ ] ORM context addressed.

## MCP Dependencies
- `@upstash/context7-mcp`: Library documentation and examples.
- `@modelcontextprotocol/server-sequential-thinking`: Complex reasoning.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples/references, added fields |
| 1.0.0 | 2026-03-20 | Initial release |
