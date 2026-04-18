# Integration Test Specification Template

> Fill in all fields before activating the `integration-test-generation` skill.

---

## Integration to Test

**Component:** `{{e.g. OrderService + PaymentGateway + Database}}`

**Description:** {{what integration this tests — e.g. "order creation flow from API to DB"}}

**Tech Stack:** {{e.g. Node.js + Express + Prisma + PostgreSQL}}

---

## Components Involved

| Component | Type | Real or Mock? |
|-----------|------|---------------|
| `{{e.g. OrderService}}` | service | real |
| `{{e.g. PostgreSQL}}` | database | {{real (test DB) / in-memory}} |
| `{{e.g. PaymentGateway}}` | external API | {{mock / sandbox}} |
| `{{e.g. Redis}}` | cache | {{real / mock}} |
| `{{e.g. EmailService}}` | external | mock |

---

## Test Scenarios

| Scenario | Input | Expected Outcome |
|----------|-------|-----------------|
| {{e.g. Create order — happy path}} | {{valid order data}} | {{order saved, payment charged, email queued}} |
| {{e.g. Payment failure}} | {{valid order, payment declines}} | {{order not saved, error returned}} |
| {{e.g. DB connection lost}} | {{valid order}} | {{graceful error, no partial state}} |
| {{e.g. Concurrent orders}} | {{2 simultaneous requests}} | {{both succeed, no duplicate}} |

---

## Test Setup

**Test DB:** {{e.g. PostgreSQL in Docker, SQLite in-memory}}

**DB reset strategy:** {{e.g. transaction rollback per test, truncate tables, fresh DB per suite}}

**Seed data:**
```{{language}}
{{describe or paste seed data setup}}
```

---

## Framework

**Test framework:** {{e.g. Jest + supertest, pytest + httpx, Go test}}

**Test file location:** `{{e.g. tests/integration/, __tests__/integration/}}`

**Run command:** `{{e.g. npm run test:integration, pytest tests/integration/}}`
