# Pagination Implementation Specification Template

> Fill in all fields before activating the `pagination-implementation` skill.

---

## Endpoint to Paginate

**Method + Path:** `GET /{{resource}}`

**Tech Stack:** {{e.g. Node.js + Express + Prisma, Python + FastAPI + SQLAlchemy}}

---

## Pagination Strategy

**Type:** {{cursor-based / offset-based / keyset}}

> - **Offset**: simple, supports random page jumps (`?page=3&limit=20`)
> - **Cursor**: efficient for large datasets, no random access (`?cursor=xxx&limit=20`)
> - **Keyset**: best performance, uses indexed column (`?after_id=123&limit=20`)

**Reason for choice:** {{e.g. "large dataset, no need for random page access"}}

---

## Request Parameters

**Offset-based:**
| Param | Type | Default | Max | Description |
|-------|------|---------|-----|-------------|
| `page` | integer | 1 | — | Page number (1-indexed) |
| `limit` | integer | 20 | 100 | Items per page |

**Cursor-based:**
| Param | Type | Default | Description |
|-------|------|---------|-------------|
| `cursor` | string | — | Opaque cursor from previous response |
| `limit` | integer | 20 | Items per page |

---

## Response Shape

```json
{
  "data": [],
  "pagination": {
    "total": 1500,
    "page": 1,
    "limit": 20,
    "totalPages": 75,
    "nextCursor": "{{opaque string — cursor-based only}}"
  }
}
```

---

## Data Source

**Table / Collection:** `{{table_name}}`

**Default sort:** `{{e.g. created_at DESC}}`

**Filterable fields:** `{{e.g. status, userId, createdAt range}}`

**Estimated row count:** `{{e.g. 500k rows}}`
