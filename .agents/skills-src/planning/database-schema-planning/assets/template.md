# Template: database-schema-planning

> Salin template ini dan ganti semua `{{placeholder}}` dengan nilai aktual.

---

## Database Schema Plan: {{domain_name}}

**Domain Description:** {{domain_description}}

**Tech Stack:** {{tech_stack}}

**Scale Requirements:** {{scale_requirements}}

---

### 1. Entity-Relationship Description

- {{entity_1}} has {{cardinality_1}} {{entity_2}} ({{relationship_type_1}}, FK enforced)
- {{entity_2}} has {{cardinality_2}} {{entity_3}} ({{relationship_type_2}}, FK enforced)

### 2. Table Definitions

**Table: {{table_name_1}}**

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | UUID | PK, DEFAULT gen_random_uuid() | Primary key |
| {{column_1}} | {{type_1}} | {{constraints_1}} | {{description_1}} |
| {{column_2}} | {{type_2}} | {{constraints_2}} | {{description_2}} |
| created_at | TIMESTAMPTZ | NOT NULL, DEFAULT NOW() | Creation timestamp |

### 3. Index Recommendations

- `{{index_name_1}}`: {{table_1}}({{columns_1}}) — {{rationale_1}}; selectivity: {{selectivity_1}}
- `{{index_name_2}}`: {{table_2}}({{columns_2}}) — {{rationale_2}}; selectivity: {{selectivity_2}}

### 4. Relationship Constraints

- `{{constraint_1}}`: {{child_table_1}}.{{fk_column_1}} → {{parent_table_1}}.id, ON DELETE {{delete_behavior_1}}
- `{{constraint_2}}`: {{child_table_2}}.{{fk_column_2}} → {{parent_table_2}}.id, ON DELETE {{delete_behavior_2}}

### 5. Migration Notes

- Migration order: {{migration_order}}
- Seed data: {{seed_data_requirements}}
- Denormalization notes: {{denormalization_notes}}
