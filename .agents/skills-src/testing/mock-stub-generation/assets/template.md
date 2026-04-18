# Mock / Stub Specification Template

> Fill in all fields before activating the `mock-stub-generation` skill.

---

## Dependency to Mock

**Dependency Name:** `{{e.g. PaymentGateway, EmailService, UserRepository, StripeClient}}`

**Type:** {{external API / database / file system / internal service / third-party SDK}}

**Why mock it:** {{e.g. "avoid real charges in tests", "no network in CI", "control return values"}}

---

## Interface / Methods to Mock

```{{language}}
{{paste the interface, class, or function signatures to mock}}
```

| Method | Signature | Returns |
|--------|-----------|---------|
| `{{methodName}}` | `({{params}}): {{ReturnType}}` | {{description}} |
| `{{methodName}}` | `({{params}}): Promise<{{ReturnType}}>` | {{description}} |

---

## Mock Scenarios Needed

| Scenario | Method | Return Value / Behavior |
|----------|--------|------------------------|
| Success | `{{method}}` | `{{e.g. { id: "123", status: "paid" }}}` |
| Not found | `{{method}}` | `{{e.g. null / throw NotFoundError}}` |
| Network error | `{{method}}` | `{{e.g. throw new Error("Network timeout")}}` |
| Partial failure | `{{method}}` | `{{e.g. first call succeeds, second fails}}` |

---

## Tech Stack

**Language / Framework:** {{e.g. TypeScript + Jest, Python + pytest, Go + testify}}

**Mock library:** {{e.g. jest.fn(), unittest.mock, gomock, sinon, vitest}}

**DI / injection method:** {{e.g. constructor injection, module mock, monkey-patch}}

---

## Usage Context

**Test file:** `{{e.g. tests/unit/OrderService.test.ts}}`

**Unit under test:** `{{e.g. OrderService}}`

**How mock is injected:**
```{{language}}
{{e.g. const service = new OrderService(mockPaymentGateway)}}
```
