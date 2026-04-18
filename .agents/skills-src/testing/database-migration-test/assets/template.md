# Database Migration Test Specification Template

> Fill in all fields before activating the `database-migration-test` skill.

---

## Migration Info

**Migration File:** `{{e.g. 20260320_add_status_to_orders.sql}}`

**Description:** {{what this migration does — e.g. "adds status column to orders, backfills existing rows"}}

**DB Engine:** {{PostgreSQL / MySQL / SQLite / MSSQL}}

**ORM / Migration Tool:** {{e.g. Prisma, Flyway, Alembic, Laravel Migrations, Knex}}

---

## Migration Changes

### Schema Changes

| Change Type | Table | Column / Index | Details |
|-------------|-------|----------------|---------|
| ADD COLUMN | `{{table}}` | `{{column}}` | {{type, nullable, default}} |
| DROP COLUMN | `{{table}}` | `{{column}}` | {{was: type}} |
| ADD INDEX | `{{table}}` | `{{index_name}}` | {{columns, unique?}} |
| ALTER COLUMN | `{{table}}` | `{{column}}` | {{from → to}} |
| ADD TABLE | `{{table}}` | — | {{description}} |

### Data Changes (if any)

```sql
-- Backfill / data transformation
{{paste the data migration SQL}}
```

---

## Test Scenarios

| Scenario | Type | Expected Result |
|----------|------|-----------------|
| Migration runs on empty DB | forward | no errors |
| Migration runs on DB with existing data | forward | data preserved, backfill correct |
| Rollback (down migration) | backward | schema restored, no data loss |
| Concurrent migration + app traffic | forward | no deadlocks, no downtime |
| {{custom scenario}} | {{type}} | {{expected}} |

---

## Data Validation

**After migration, verify:**
```sql
-- Example: verify backfill
SELECT COUNT(*) FROM {{table}} WHERE {{column}} IS NULL;
-- Expected: 0

SELECT COUNT(*) FROM {{table}} WHERE {{column}} = '{{expected_default}}';
-- Expected: {{row count before migration}}
```

---

## Rollback Plan

**Down migration available:** {{yes/no}}

**Rollback command:** `{{e.g. prisma migrate reset, flyway undo}}`

**Data recovery:** {{e.g. restore from backup taken before migration}}
