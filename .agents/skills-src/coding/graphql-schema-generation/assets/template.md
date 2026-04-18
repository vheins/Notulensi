# GraphQL Schema Specification Template

> Fill in all fields before activating the `graphql-schema-generation` skill.

---

## Domain Overview

**Domain:** {{e.g. e-commerce, blog, SaaS platform}}

**Tech Stack:** {{e.g. Node.js + Apollo Server + Prisma, Python + Strawberry + SQLAlchemy}}

---

## Types to Define

### Type: `{{TypeName}}`

| Field | Type | Nullable | Description |
|-------|------|----------|-------------|
| `id` | `ID!` | no | Unique identifier |
| `{{field}}` | `{{GraphQL type}}` | {{yes/no}} | {{description}} |
| `createdAt` | `String!` | no | ISO 8601 timestamp |

**Relationships:**
| Field | Type | Cardinality |
|-------|------|-------------|
| `{{field}}` | `{{OtherType}}` | {{one-to-one / one-to-many / many-to-many}} |

---

## Queries

| Query | Return Type | Args | Description |
|-------|-------------|------|-------------|
| `{{queryName}}` | `{{Type}}` | `id: ID!` | {{description}} |
| `{{queryName}}` | `[{{Type}}!]!` | `filter: {{FilterInput}}` | {{description}} |

---

## Mutations

| Mutation | Return Type | Input | Description |
|----------|-------------|-------|-------------|
| `create{{Type}}` | `{{Type}}!` | `Create{{Type}}Input!` | {{description}} |
| `update{{Type}}` | `{{Type}}!` | `Update{{Type}}Input!` | {{description}} |
| `delete{{Type}}` | `Boolean!` | `id: ID!` | {{description}} |

---

## Subscriptions (if needed)

| Subscription | Payload | Trigger |
|--------------|---------|---------|
| `{{subscriptionName}}` | `{{Type}}` | {{e.g. on create, on status change}} |

---

## Auth / Permissions

| Operation | Required Role |
|-----------|---------------|
| `{{query/mutation}}` | {{e.g. authenticated, admin, owner}} |
