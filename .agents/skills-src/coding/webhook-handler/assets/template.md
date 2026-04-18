# Webhook Handler Specification Template

> Fill in all fields before activating the `webhook-handler` skill.

---

## Webhook Info

**Provider:** {{e.g. Stripe, GitHub, Shopify, Twilio, custom}}

**Webhook URL:** `POST /webhooks/{{provider}}`

**Documentation:** {{URL to provider webhook docs}}

---

## Events to Handle

| Event Name | Description | Action |
|------------|-------------|--------|
| `{{event.name}}` | {{e.g. payment succeeded}} | {{e.g. update order status to paid}} |
| `{{event.name}}` | {{e.g. subscription cancelled}} | {{e.g. downgrade user plan}} |
| `{{event.name}}` | {{e.g. refund issued}} | {{e.g. create refund record}} |

---

## Payload Structure

```json
{
  "id": "{{event-id}}",
  "type": "{{event.name}}",
  "data": {
    "object": {
      "{{field}}": "{{value}}"
    }
  }
}
```

---

## Security

**Signature verification:**
| Setting | Value |
|---------|-------|
| Header | `{{e.g. Stripe-Signature, X-Hub-Signature-256}}` |
| Secret env var | `{{e.g. STRIPE_WEBHOOK_SECRET}}` |
| Algorithm | {{e.g. HMAC-SHA256}} |

**IP allowlist:** {{yes/no — provider IPs only}}

---

## Processing Requirements

| Requirement | Detail |
|-------------|--------|
| Idempotency | {{yes — check event ID before processing}} |
| Async processing | {{yes/no — queue to background job}} |
| Retry handling | {{e.g. provider retries up to 3x, must be idempotent}} |
| Response timeout | {{e.g. must respond 200 within 5s}} |
| Failed event storage | {{yes/no — store for manual replay}} |

---

## Tech Stack

**Stack:** {{e.g. Node.js + Express + TypeScript + BullMQ}}

**DB model for idempotency:** `{{e.g. WebhookEvent(id, type, processedAt)}}`
