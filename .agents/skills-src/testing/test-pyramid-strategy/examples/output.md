# Example Output: test-pyramid-strategy

## Example 1: SaaS startup with no test strategy

**Recommended Test Pyramid**

```
         /\
        /E2E\        10% — 15 tests — Playwright — pre-release only
       /------\
      /  Integ  \    20% — 40 tests — Jest + supertest — every PR
     /------------\
    /     Unit      \  70% — 120 tests — Jest — every commit
   /------------------\
```

**Phase 1 — Week 1–2: Unit tests for business logic (highest ROI)**

Start with pure functions and services — no DB, no HTTP:
- `calculateDiscount`, `validatePassword`, `formatInvoice`
- `OrderService`, `UserService` (with mocked repos)
- Target: 80 unit tests, <30s CI

**Phase 2 — Week 3–4: Integration tests for critical API paths**

Test the 5 most important endpoints with real DB (test PostgreSQL):
- `POST /auth/login`, `POST /auth/register`
- `POST /orders`, `GET /orders/:id`
- `POST /billing/subscribe`
- Target: 25 integration tests, <3min CI

**Phase 3 — Week 5–6: E2E for critical user journeys**

Only the flows that generate revenue or block users:
- Registration → login → create first project
- Checkout → payment → order confirmation
- Password reset flow
- Target: 10 E2E tests, <10min CI (run nightly + pre-release)

**CI Pipeline**

```yaml
on: [push]
jobs:
  unit:       # every commit, <1min
    run: npm run test:unit
  integration: # every PR, <5min
    run: npm run test:integration
  e2e:        # nightly + pre-release only
    run: npm run test:e2e
```

**Expected outcome after 6 weeks:** Manual QA time drops from 2h to 15min. Production bugs drop by ~70%.
