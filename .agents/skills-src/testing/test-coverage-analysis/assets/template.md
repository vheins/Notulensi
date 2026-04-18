# Test Coverage Analysis Template

> Fill in all fields before activating the `test-coverage-analysis` skill.

---

## Project Info

**Project:** `{{project-name}}`

**Tech Stack:** {{e.g. TypeScript + Jest, Python + pytest, Go test}}

**Coverage Tool:** {{e.g. Istanbul/nyc, coverage.py, go cover}}

---

## Current Coverage Report

```
{{paste coverage report output here}}
```

Or provide summary:

| Metric | Current | Target |
|--------|---------|--------|
| Line coverage | {{e.g. 62%}} | {{e.g. 80%}} |
| Branch coverage | {{e.g. 45%}} | {{e.g. 70%}} |
| Function coverage | {{e.g. 70%}} | {{e.g. 85%}} |
| Statement coverage | {{e.g. 60%}} | {{e.g. 80%}} |

---

## Files with Low Coverage

| File | Line % | Branch % | Priority |
|------|--------|----------|----------|
| `{{src/services/OrderService.ts}}` | {{e.g. 30%}} | {{e.g. 20%}} | high |
| `{{src/utils/discount.ts}}` | {{e.g. 45%}} | {{e.g. 35%}} | high |
| `{{src/controllers/AuthController.ts}}` | {{e.g. 55%}} | {{e.g. 40%}} | medium |

---

## Coverage Exclusions (intentional)

| Pattern | Reason |
|---------|--------|
| `{{src/generated/**}}` | auto-generated code |
| `{{src/migrations/**}}` | tested via DB migration tests |
| `{{src/types/**}}` | type definitions only |

---

## Coverage Goals

**Minimum threshold (CI gate):**
| Metric | Threshold |
|--------|-----------|
| Lines | {{e.g. 75%}} |
| Branches | {{e.g. 65%}} |
| Functions | {{e.g. 80%}} |

**Coverage command:** `{{e.g. npm run test:coverage, pytest --cov=src}}`

**Report format:** {{e.g. HTML (open coverage/index.html), lcov, text}}
