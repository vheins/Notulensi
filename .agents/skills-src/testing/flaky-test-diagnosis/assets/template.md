# Flaky Test Diagnosis Template

> Fill in all fields before activating the `flaky-test-diagnosis` skill.

---

## Flaky Test Info

**Test Name / File:** `{{e.g. OrderService > should create order, tests/integration/checkout.test.ts}}`

**Test Framework:** {{e.g. Jest, pytest, RSpec, Go test}}

**Failure Rate:** {{e.g. fails ~30% of runs, fails only in CI}}

---

## Failure Pattern

**When does it fail?**
- [ ] Only in CI (not locally)
- [ ] Only when run in parallel with other tests
- [ ] Only after a specific test runs
- [ ] Randomly, no clear pattern
- [ ] Only under load / slow machine
- [ ] Only at certain times (timezone, date-related)

**Error message when it fails:**
```
{{paste the error / stack trace}}
```

---

## Test Code

```{{language}}
{{paste the flaky test}}
```

---

## Suspected Causes

| Cause | Likely? | Evidence |
|-------|---------|----------|
| Shared mutable state between tests | {{yes/no/maybe}} | {{e.g. global variable modified}} |
| Async timing issue (missing await) | {{yes/no/maybe}} | {{e.g. assertion before async op completes}} |
| Test order dependency | {{yes/no/maybe}} | {{e.g. passes when run alone}} |
| External service / network call | {{yes/no/maybe}} | {{e.g. calls real API}} |
| Date/time dependency | {{yes/no/maybe}} | {{e.g. uses Date.now()}} |
| Random data without seed | {{yes/no/maybe}} | {{e.g. Math.random()}} |
| DB not cleaned between tests | {{yes/no/maybe}} | {{e.g. leftover rows}} |

---

## Environment

**CI Platform:** {{e.g. GitHub Actions, GitLab CI}}

**Parallelism:** {{e.g. 4 workers, sequential}}

**Test isolation:** {{e.g. each test uses transaction rollback, shared DB}}
