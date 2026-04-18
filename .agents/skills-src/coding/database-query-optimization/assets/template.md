# Database Query Optimization Specification Template

> Fill in all fields before activating the `database-query-optimization` skill.

---

## Slow Query

**Query (SQL or ORM):**
```sql
{{paste the slow query here}}
```

**ORM equivalent (if applicable):**
```{{language}}
{{e.g. User.findAll({ include: [{ model: Post }] })}}
```

---

## Performance Data

| Metric | Value |
|--------|-------|
| Avg execution time | {{e.g. 2.3s}} |
| P95 execution time | {{e.g. 8s}} |
| Rows scanned | {{e.g. 500k}} |
| Rows returned | {{e.g. 20}} |
| Frequency | {{e.g. called on every page load, ~1000/min}} |

**EXPLAIN / EXPLAIN ANALYZE output:**
```
{{paste EXPLAIN output here}}
```

---

## Schema Context

**Relevant Tables:**
```sql
CREATE TABLE {{table_name}} (
  id uuid PRIMARY KEY,
  {{column}} {{type}},
  -- ...
);
```

**Existing Indexes:**
```sql
{{list existing indexes on relevant tables}}
```

---

## Database

**Engine:** {{PostgreSQL / MySQL / SQLite / MSSQL}}

**Version:** {{e.g. PostgreSQL 15}}

**Table Size:** {{e.g. users: 2M rows, orders: 10M rows}}

---

## Constraints

**Cannot change:** {{e.g. table schema (used by other services), query result shape}}

**Can change:** {{e.g. add indexes, rewrite query, add materialized view}}
