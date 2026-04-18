---
name: database-query-optimization
description: >
  Use when a developer has a slow or expensive database query and needs analysis, index recommendations,
  and a rewritten optimized version. Activate for query performance, EXPLAIN output
  interpretation, or index strategy for any relational or document database.
  Do NOT use for schema design from scratch, ORM configuration, or general database architecture.
version: "1.1.0"
time_saved: "Manual: 2–4 hours | With skill: 15–30 minutes"
license: Proprietary — Personal Use Only
category: coding
complexity: Advanced
tokens: ~4500
tags: [database, query-optimization, indexes, performance, sql, explain-plan]
author: vheins
---

# Skill: Database Query Optimization

## Purpose
Analyze slow queries using EXPLAIN data, recommend optimized indexing strategies, and produce efficient query rewrites.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | DB + ORM (e.g., "PostgreSQL + Prisma") |
| `slow_query` | string | Yes | SQL, ORM code, or aggregation pipeline |
| `schema` | string | Yes | Table/Collection schema + current indexes |
| `explain_output` | string | No | Output from EXPLAIN / EXPLAIN ANALYZE |

## Instructions
- **Diagnosis**: Identify root causes (Sequential scans, missing indexes, N+1 patterns, inefficient joins, `SELECT *`).
- **Indexing**: Provide exact `CREATE INDEX` statements. Justify index types (B-tree, GIN, etc.) and estimate row scan reduction.
- **Optimization**: Rewrite the query for maximum efficiency; explain each structural change.
- **Impact**: Summarize "Before vs After" (rows scanned, plan type, latency magnitude).
- **Trade-offs**: Note write overhead, behavioral changes, and maintenance (Vacuum/Stats).

## Edge Cases
| Case | Strategy |
|------|----------|
| No EXPLAIN output | Structural analysis only; recommend running EXPLAIN ANALYZE. |
| ORM-generated query | Show generated SQL; optimize at both ORM and SQL levels. |
| NoSQL (MongoDB) | Adapt to aggregation pipelines and document-specific indexing. |

## Optimization Flow
```mermaid
flowchart TD
    A([Start: slow_query + schema + tech_stack]) --> B{explain_output?}
    B -- Yes --> C[Interpret EXPLAIN/ANALYZE]
    B -- No --> D[Structural analysis only\nrecommend ANALYZE]
    C & D --> E[Problem Diagnosis]
    E --> E1{Sequential scan?}
    E1 -- Yes --> F[Recommend Index]
    E --> E2{N+1 / Subquery?}
    E2 -- Yes --> G[Rewrite as JOIN/EXISTS]
    E --> E3{SELECT * used?}
    E3 -- Yes --> H[Project columns]
    E --> E4{Inefficient Join?}
    E4 -- Yes --> I[Reorder/Hint Join]
    F & G & H & I --> J[Finalize Index Recs]
    J --> K{ORM query?}
    K -- Yes --> L[Show SQL + Optimize both]
    K -- No --> M
    L & M --> N[Write Optimized Query]
    N --> O[Impact Summary\n10x/100x improvement]
    O --> P[Trade-offs\nWrite overhead + Maintenance]
    P --> Q([Output: Diagnosis + Indexing\n+ Query + Impact + Trade-offs])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
1. Is the diagnosis based on evidence?
2. Are index statements syntactically correct?
3. Is write overhead addressed?
4. Are ORM vs SQL differences handled?
5. Is the output production-ready?

## MCP Dependencies
- `@upstash/context7-mcp`: Library documentation and examples.
- `@modelcontextprotocol/server-sequential-thinking`: Complex reasoning.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples to examples/, references to references/, added compatibility and license fields |
| 1.0.0 | 2026-03-20 | Initial release |
