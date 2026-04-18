---
name: database-schema-planning
description: Designs a normalized database schema with tables, fields, indexes, relationships, and migration notes. DO NOT use for query optimization, ORM generation, or existing schema documentation.
version: "1.1.0"
time_saved: "Manual: 4–8 hours | With skill: 20–45 minutes"
license: Proprietary — Personal Use Only
category: planning
complexity: Advanced
tokens: ~5000
tags: [database, schema, normalization, indexes, relationships, migration, ERD]
author: vheins
---

# Skill: Database Schema Planning

## Purpose
Generate a normalized relational schema plan including ERD, table definitions, and migration strategies.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `domain_description` | string | Yes | Entities and domain |
| `tech_stack` | string | Yes | DB and ORM details |
| `scale_requirements` | string | Yes | Volume and query patterns |

## Instructions
- **ERD Description**: Define relationships (1:1, 1:N, M:N), cardinality, and FK enforcement.
- **Mermaid Diagram**: Provide a visual ERD with exact column types (e.g., `varchar(255)`) and constraints.
- **Table Specs**: For every table, list columns with types, NOT NULL, UNIQUE, and soft delete (`deleted_at`).
- **Indexes**: Recommend non-PK indexes with rationale and estimated selectivity.
- **Constraints**: List all Foreign Keys with `ON DELETE` behavior.
- **Normalization**: Target 3NF; flag and justify any denormalization based on scale needs.
- **Migrations**: Define creation order, nullable-first strategies, and seed requirements.

## Edge Cases
| Case | Strategy |
|------|----------|
| Many-to-Many | Always create an explicit junction table with its own PK and timestamps. |
| Soft Delete | Include `deleted_at TIMESTAMPTZ` and recommend partial indexes for active data. |
| Vague Scale | Stop; request row count estimates and query patterns before indexing. |

## Workflow
```mermaid
flowchart TD
    A([Start: DB Schema Planning]) --> B{scale_requirements\nprovided?}
    B -- Vague/Missing --> C[Ask for row counts\nand primary query patterns\nbefore recommending indexes]
    C --> B
    B -- Yes --> D[Write Entity-Relationship Description\nrelationship types + cardinality\nFK enforced vs application-layer]
    D --> E[Generate Mermaid ERD\nexact SQL types per column\nPK / FK / UK markers]
    E --> F[Define Table Definitions\ncolumn + type + constraints\nNOT NULL + UNIQUE + DEFAULT\nsoft delete deleted_at where applicable]
    F --> G{Many-to-many\nrelationships found?}
    G -- Yes --> H[Create explicit junction table\nwith own PK + additional attributes]
    G -- No --> I[Write Index Recommendations\nbeyond primary keys\nB-tree/GIN/partial\nrationale + selectivity]
    H --> I
    I --> J[List Relationship Constraints\nFK constraint names\nON DELETE behavior + rationale]
    J --> K[Write Migration Notes\ncreation order\nnullable-first strategy\nseed data requirements]
    K --> L{Any denormalization\nin schema?}
    L -- Yes --> M[Flag denormalization decision\nwith explicit rationale\nfrom scale requirements]
    L -- No --> N([Output: 6-section schema plan\n600–1200 words])
    M --> N
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] 3NF normalization achieved (or denormalization justified).
- [ ] Mermaid ERD uses exact SQL types.
- [ ] Junction tables used for M:N.
- [ ] Soft delete included.
- [ ] Creation order is logical.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.2.0 | 2026-03-21 | Mandatory Mermaid ERD. 5 → 6 sections. |
| 1.1.0 | 2026-03-20 | Restructured: moved examples/references, added compatibility/license |
| 1.0.0 | 2026-03-20 | Initial release |
