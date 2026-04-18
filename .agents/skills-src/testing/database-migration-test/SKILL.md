---
name: database-migration-test
description: >
  Generates tests for database migrations covering forward migration, rollback, and data integrity.
  Do NOT use for application-level tests or ORM query tests.
version: "1.1.0"
time_saved: "Manual: 3-4 hours | With skill: 10-15 minutes"
license: Proprietary — Personal Use Only
category: testing
complexity: Advanced
tokens: ~4000
tags: [database-migrations, migration-testing, schema-testing, data-integrity]
author: vheins
---

# Skill: Database Migration Test

## Purpose
Generate tests verifying that forward migrations apply correctly, rollbacks restore previous state, and data integrity is maintained.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `migration_code` | string | Yes | Migration file(s) (up/down) |
| `tech_stack` | string | Yes | e.g., "Node.js + Knex + Postgres" |
| `data_scenario` | string | No | Existing data scenario |

## Instructions
- **Forward Migration**: Verify new schema, column types, constraints, indexes, and default values.
- **Rollback**: Verify schema restoration and idempotency; ensure rollback doesn't crash.
- **Data Integrity**: Verify that existing data survives transformations and that constraints (FK) are enforced.
- **Edge Cases**: Test empty tables, nulls, duplicates on new unique constraints, and maximum row counts.
- **Idempotency**: Ensure running `up` or `down` twice in a row does not cause errors.
- **Lifecycle**: For every test: setup state → run migration → assert post-state → clean up.

## Edge Cases
| Case | Strategy |
|------|----------|
| Irreversible | Document impossibility of rollback; focus entirely on forward verification. |
| Large tables | Test performance/duration; add progress logging assertions. |
| Zero-downtime | Test migration behavior during simulated concurrent traffic. |

## Workflow
```mermaid
flowchart TD
    A([Start: DB Migration Test]) --> B[Parse migration_code,
tech_stack, data_scenario]
    B --> C[Analyze up/down functions]
    C --> D{Irreversible?}
    D -- Yes --> E[Document no rollback test.
Focus on forward migration]
    D -- No --> F[Plan up + down tests]
    E & F --> G[Test Forward Migration - up]
    G --> G1[Verify schema, columns, constraints,
indexes, defaults]
    G1 --> H{data_scenario
provided?}
    H -- Yes --> I[Seed DB with scenario data]
    H -- No --> J[Use empty table + standard data]
    I & J --> K[Verify data preserved]
    K --> L{Rollback possible?}
    L -- Yes --> M[Test Rollback Migration - down
Schema restored, data preserved]
    L -- No --> N
    M --> N[Test Round-Trip
up → down → up]
    N --> O[Test Edge Cases
Empty table, nulls, duplicates,
constraint violations]
    O --> P{Large table?}
    P -- Yes --> Q[Add performance test
progress logging]
    P -- No --> R
    Q & R --> S[Test Idempotency
run up/down twice]
    S --> T([Output: Migration Test File])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] Both forward and rollback migrations tested.
- [ ] Existing data preservation verified.
- [ ] Constraint violations tested.
- [ ] Round-trip (up-down-up) tested.
- [ ] Edge cases (empty/large tables) covered.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples, references, added metadata |
| 1.0.0 | 2026-03-20 | Initial release |
