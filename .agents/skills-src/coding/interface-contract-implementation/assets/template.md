# Interface Contract Specification Template

> Fill in all fields before activating the `interface-contract-implementation` skill.

---

## Interface Definition

**Interface Name:** `{{InterfaceName}}` *(e.g. `PaymentProvider`, `NotificationService`)*

**Purpose:** {{what this interface abstracts — e.g. "unified contract for multiple payment gateways"}}

**Tech Stack:** {{e.g. TypeScript, Java + Spring, Go, PHP}}

---

## Methods

| Method | Signature | Description |
|--------|-----------|-------------|
| `{{methodName}}` | `({{params}}): {{ReturnType}}` | {{description}} |
| `{{methodName}}` | `({{params}}): Promise<{{ReturnType}}>` | {{description}} |

**Method Details:**

### `{{methodName}}`

**Input:**
```typescript
{{param}}: {
  {{field}}: {{type}};
}
```

**Output:**
```typescript
{
  {{field}}: {{type}};
}
```

**Throws / Error cases:**
- `{{ErrorType}}` — {{when this is thrown}}

---

## Implementations to Generate

| Implementation | Description |
|----------------|-------------|
| `{{ClassName}}` | {{e.g. StripePaymentProvider — uses Stripe SDK}} |
| `{{ClassName}}` | {{e.g. MockPaymentProvider — for testing}} |

---

## Dependency Injection

**DI Framework:** {{e.g. tsyringe, InversifyJS, Spring, none — manual}}

**Registration:** {{e.g. bind PaymentProvider to StripePaymentProvider in container}}

---

## Constraints

- {{e.g. all implementations must be stateless}}
- {{e.g. must not throw — return Result type instead}}
- {{e.g. must be async-safe}}
