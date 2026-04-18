# Template: database-documentation

> Salin template ini dan ganti semua `{{placeholder}}` dengan nilai aktual.

---

## Database Schema Documentation

**Database:** {{database_type}}
**Generated:** {{generation_date}}

### Table: `{{table_name}}`

**Overview:** {{table_description}}

| Column | Type | Nullable | Default | Description |
|--------|------|----------|---------|-------------|
| `{{column_1}}` | `{{type_1}}` | {{nullable_1}} | {{default_1}} | {{description_1}} |
| `{{column_2}}` | `{{type_2}}` | {{nullable_2}} | {{default_2}} | {{description_2}} |

**Indexes:**
- `{{index_name}}` — {{index_type}} on `{{index_columns}}`

**Relationships:**
- `{{table_name}}.{{fk_column}}` → `{{referenced_table}}.{{referenced_column}}` ({{on_delete_action}})

## Entity Relationship Diagram

```
{{erd_diagram}}
```
