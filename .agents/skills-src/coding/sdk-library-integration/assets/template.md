# SDK / Library Integration Specification Template

> Fill in all fields before activating the `sdk-library-integration` skill.

---

## Integration Info

**SDK / Library:** `{{package-name}}` v{{version}}

**Purpose:** {{what this SDK does — e.g. "Stripe for payment processing", "Twilio for SMS", "AWS S3 for file storage"}}

**Official Docs:** {{URL}}

---

## Tech Stack

**Stack:** {{e.g. Node.js + TypeScript + Express, Python + FastAPI}}

**Package Manager:** {{npm / pip / go get / composer}}

---

## Features to Integrate

| Feature | Description | Priority |
|---------|-------------|----------|
| `{{feature}}` | {{e.g. charge a card}} | {{high/medium/low}} |
| `{{feature}}` | {{e.g. create a customer}} | {{high/medium/low}} |
| `{{feature}}` | {{e.g. handle webhooks}} | {{high/medium/low}} |

---

## Configuration

**Required credentials / keys:**
| Variable | Description |
|----------|-------------|
| `{{SDK_API_KEY}}` | {{description}} |
| `{{SDK_SECRET}}` | {{description}} |

**SDK initialization:**
```{{language}}
// How you expect to initialize the SDK
{{e.g. const stripe = new Stripe(process.env.STRIPE_SECRET_KEY)}}
```

---

## Integration Pattern

**Wrapper / abstraction:** {{yes/no — wrap SDK behind interface for testability}}

**Error handling:** {{e.g. catch SDK errors, map to domain errors}}

**Retry logic:** {{yes/no — SDK handles it / custom}}

**Testing approach:** {{e.g. mock SDK, use sandbox/test mode, record & replay}}

---

## Existing Code Context

**Where integration lives:** `{{e.g. src/services/PaymentService.ts}}`

**Relevant models:** `{{e.g. Order, Payment}}`
