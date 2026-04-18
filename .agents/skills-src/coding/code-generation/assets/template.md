# Code Generation Specification Template

> Fill in all fields before activating the `code-generation` skill.

---

## What to Generate

**Output Type:** {{e.g. CRUD service, data model, CLI command, React component, migration file}}

**Tech Stack:** {{e.g. TypeScript + Express + Prisma, Python + FastAPI + SQLAlchemy}}

---

## Entity / Domain

**Entity Name:** `{{EntityName}}`

**Fields:**
| Field | Type | Required | Constraints |
|-------|------|----------|-------------|
| `id` | uuid | yes | PK, auto-generated |
| `{{field}}` | {{type}} | {{yes/no}} | {{e.g. unique, max 255}} |
| `created_at` | timestamp | yes | auto |
| `updated_at` | timestamp | yes | auto |

**Relationships:**
| Relation | Type | Target Entity |
|----------|------|---------------|
| `{{field}}` | {{belongs_to / has_many / many_to_many}} | `{{OtherEntity}}` |

---

## Operations to Generate

| Operation | Include? | Notes |
|-----------|----------|-------|
| Create | {{yes/no}} | |
| Read (single) | {{yes/no}} | |
| Read (list + pagination) | {{yes/no}} | |
| Update | {{yes/no}} | |
| Delete (soft/hard) | {{yes/no}} | {{soft / hard}} |
| Search / filter | {{yes/no}} | {{fields to filter by}} |

---

## Conventions

**Layer pattern:** {{e.g. controller → service → repository, MVC, clean architecture}}

**Validation library:** {{e.g. Zod, Joi, class-validator, Pydantic}}

**Error format:** `{{e.g. { error: string, details?: object }}}`

**Naming convention:** {{e.g. camelCase methods, snake_case DB columns}}
