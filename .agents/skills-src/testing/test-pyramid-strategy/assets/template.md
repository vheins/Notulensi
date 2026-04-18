# Test Pyramid Strategy Template

> Fill in all fields before activating the `test-pyramid-strategy` skill.

---

## Project Info

**Project:** `{{project-name}}`

**Architecture:** {{e.g. monolith, microservices, serverless}}

**Tech Stack:** {{e.g. Node.js + Express + PostgreSQL + React}}

---

## Current Test State

| Layer | Count | Coverage | Framework |
|-------|-------|----------|-----------|
| Unit tests | {{e.g. 50}} | {{e.g. 40%}} | {{e.g. Jest}} |
| Integration tests | {{e.g. 10}} | {{e.g. 20%}} | {{e.g. Jest + supertest}} |
| E2E tests | {{e.g. 5}} | {{e.g. 10%}} | {{e.g. Playwright}} |

**Main pain points:**
- {{e.g. too many E2E tests, slow CI (20 min)}}
- {{e.g. no unit tests, everything is integration}}
- {{e.g. flaky E2E tests blocking deploys}}

---

## Target Test Pyramid

| Layer | Target % | Target Count | Run Time |
|-------|----------|--------------|----------|
| Unit | {{e.g. 70%}} | {{e.g. 300}} | < {{e.g. 30s}} |
| Integration | {{e.g. 20%}} | {{e.g. 80}} | < {{e.g. 3 min}} |
| E2E | {{e.g. 10%}} | {{e.g. 30}} | < {{e.g. 10 min}} |

---

## What to Test at Each Layer

### Unit Tests
- Pure functions, utilities, business logic
- Service layer (with mocked dependencies)
- {{project-specific: e.g. discount calculations, validation rules}}

### Integration Tests
- API endpoints (with real DB, mocked external services)
- DB queries and transactions
- {{project-specific: e.g. order creation flow}}

### E2E Tests
- Critical user journeys only
- {{e.g. registration → login → checkout → confirmation}}
- {{e.g. admin creates product → user can purchase}}

---

## CI Strategy

| Layer | Trigger | Max Duration |
|-------|---------|--------------|
| Unit | every commit | {{e.g. 1 min}} |
| Integration | every PR | {{e.g. 5 min}} |
| E2E | pre-release / nightly | {{e.g. 15 min}} |
