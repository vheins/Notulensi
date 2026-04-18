---
name: database-documentation
description: >
  Generate comprehensive database schema documentation from SQL DDL, ORM models, or migrations. Covers tables, columns, constraints, indexes, and relationships.
  Do NOT use for query optimization, migration planning, or schema design advice.
version: "1.1.0"
time_saved: "Manual: 3–4 hours | With skill: 15–20 minutes"
license: Proprietary — Personal Use Only
category: documentation
complexity: Intermediate
tokens: ~7500
tags: [database, schema, documentation, sql, erd, tables, indexes, constraints]
author: vheins
---

# Agent Optimized: Database Documentation

## Directives
- **Overview**: Summarize database purpose, table count, and primary entities.
- **Tables**: Document Purpose, Columns (Type, Nullable, Default, Description), PKs, FKs, and Constraints.
- **Indexes**: Provide Table (Index Name, Table, Columns, Type, Purpose).
- **ERD Summary**: Plain text relationships using `TableA (cardinality) TableB` notation.
- **Notes/Warnings**: Flag performance issues, nullable FKs, or non-nullable columns without defaults.

## Constraints
- **Scope**: Use `{{schema_source}}` and `{{database_type}}` for analysis.
- **Assumptions**: State assumptions clearly if schema is ambiguous.
- **Naming**: Junction tables must be explicitly named.

## Strategy: Edge Cases
| Case | Strategy |
|------|----------|
| No foreign keys | Flag inferred relationships lacking explicit FK constraints. |
| ORM input | Parse ORM syntax (Prisma, SQLAlchemy); note framework behavior. |
| Large schema (20+) | Prepend a Table Index with one-line descriptions. |
| Ambiguous types | Document declared affinity; note dynamic typing behavior. |

## Format
- Markdown headers (`##`, `###`).
- Tables for columns and indexes.
- Relationship notation: `(1) ←→ (N)`.
- Word Count: 300–1,500 words.

## Verification: Senior Review
- [ ] Columns table includes data types and nullability?
- [ ] All foreign key relationships identified (explicit or implied)?
- [ ] Primary keys and unique constraints marked?
- [ ] Performance-critical indexes documented?

## Metadata
- **Path**: `.agents/documents/design/database/`
- **Mermaid**:
```mermaid
flowchart TD
    A([Start]) --> B{schema format?}
    B -- SQL DDL --> C[Parse CREATE statements]
    B -- ORM models --> D[Parse ORM syntax]
    B -- Migrations --> E[Reconstruct from sequence]
    C & D & E --> F[Write Overview]
    F --> G[For each table: document columns]
    G --> H[Extract PKs, FKs, constraints]
    H --> I{context provided?}
    I -- Yes --> J[Domain-specific descriptions]
    I -- No --> K[Generic descriptions]
    J & K --> L[Build Indexes table]
    L --> M[Write ERD Relationships]
    M --> N{Implied FK without constraint?}
    N -- Yes --> O[Flag in Notes]
    N -- No --> P[Check for missing non-PK indexes]
    O --> P
    P --> Q{Tables without indexes?}
    Q -- Yes --> R[Flag performance concern]
    Q -- No --> S[Finalize]
    R --> S
    S --> T([Output: DB schema doc])
```
