# REST to GraphQL Migration Specification Template

> Fill in all fields before activating the `rest-to-graphql-migration` skill.

---

## Migration Scope

**Tech Stack:** {{e.g. Node.js + Express → Apollo Server, Python + FastAPI → Strawberry}}

**Scope:** {{full migration / add GraphQL alongside REST / specific endpoints only}}

---

## REST Endpoints to Migrate

| Method | Path | Description | Priority |
|--------|------|-------------|----------|
| `GET` | `/{{resource}}` | List {{resource}} | {{high/medium/low}} |
| `GET` | `/{{resource}}/:id` | Get single {{resource}} | {{high/medium/low}} |
| `POST` | `/{{resource}}` | Create {{resource}} | {{high/medium/low}} |
| `PUT` | `/{{resource}}/:id` | Update {{resource}} | {{high/medium/low}} |
| `DELETE` | `/{{resource}}/:id` | Delete {{resource}} | {{high/medium/low}} |

---

## Data Models

```
{{ModelName}}: { {{field}}: {{type}}, ... }
{{ModelName}}: { {{field}}: {{type}}, ... }
```

**Relationships:**
| From | To | Type |
|------|----|------|
| `{{Model}}` | `{{Model}}` | {{one-to-many / many-to-many}} |

---

## Migration Strategy

**Approach:** {{big-bang / incremental (REST + GraphQL coexist) / strangler fig}}

**Client migration:** {{all at once / gradual per client}}

**Deprecation timeline for REST:** {{e.g. 3 months after GraphQL GA}}

---

## GraphQL Requirements

| Feature | Include? |
|---------|----------|
| Queries | yes |
| Mutations | yes |
| Subscriptions | {{yes/no}} |
| DataLoader (N+1 prevention) | {{yes/no}} |
| Pagination (cursor-based) | {{yes/no}} |
| Auth (same as REST) | yes |
| Schema introspection (prod) | {{yes/no — disable in prod}} |

---

## Existing Auth

**Current auth:** {{e.g. JWT Bearer token in Authorization header}}

**GraphQL auth approach:** {{e.g. same JWT, context injection per request}}
