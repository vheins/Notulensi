---
name: webhook-handler
description: Implements a production-ready webhook receiver with signature verification, idempotency, retries, and dead letter queue. DO NOT use for outgoing webhooks or general endpoints.
version: "1.1.0"
time_saved: "Manual: 3–6 hours | With skill: 20–40 minutes"
license: Proprietary — Personal Use Only
category: coding
complexity: Advanced
tokens: ~4500
tags: [webhook, signature-verification, idempotency, dead-letter-queue, event-processing]
author: vheins
---

# Skill: Webhook Handler

## Purpose
Implement a secure, reliable webhook receiver with signature verification, idempotency, and retry handling.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `tech_stack` | string | Yes | e.g., "Node.js + Express" |
| `webhook_provider` | string | Yes | e.g., "Stripe", "GitHub" |
| `event_types` | string | Yes | Events to process |

## Instructions
- **Verification**: Retrieve raw body BEFORE parsing. Compute and compare signatures using constant-time logic. Reject invalid requests (401).
- **Idempotency**: Extract Event ID. Return 200 immediately if already processed. Mark success in Redis/DB.
- **Routing**: Dispatch to dedicated handlers per event type. Log unknown events; return 200.
- **Reliability**: Return 500 for transient failures. Move to DLQ after N attempts for manual replay.
- **Async**: For long-running tasks, return 200 immediately and enqueue for background processing.

## Edge Cases
| Case | Strategy |
|------|----------|
| Out of Order | Implement state machine or timestamp-based ordering. |
| Secret Rotation | Implement dual-secret verification (Old/New) during window. |
| High Volume | Queue events immediately; process asynchronously. |

## Workflow Logic
```mermaid
flowchart TD
    A([Start: Webhook Handler]) --> B[Receive incoming webhook request]
    B --> C[Read raw request body BEFORE JSON parsing]
    C --> D[Compute expected signature using provider algorithm: HMAC-SHA256]
    D --> E{Signature valid?}
    E -- No --> F[Return 401 immediately — reject spoofed event]
    E -- Yes --> G[Extract event ID from payload]
    G --> H{Event ID already processed?}
    H -- Yes --> I[Return 200 immediately — idempotent, skip reprocessing]
    H -- No --> J[Route by event type]
    J --> K{Event type known?}
    K -- Unknown --> L[Log + return 200 — don't fail on new event types]
    K -- Known --> M[Dispatch to specific handler function]
    M --> N{Handler processing time?}
    N -- Long-running --> O[Return 200 immediately, enqueue async job]
    N -- Fast --> P[Process inline]
    O & P --> Q{Processing success?}
    Q -- Yes --> R[Mark event ID as processed in Redis/DB]
    Q -- No: transient error --> S[Return 500 to trigger provider retry]
    Q -- No: permanent error --> T
    S --> U{Retry count exceeded?}
    U -- Yes --> T[Move to Dead Letter Queue for manual inspection + replay]
    U -- No --> V[Provider will retry automatically]
    T --> W{Secret rotation needed?}
    W -- Yes --> X[Try new secret first, fall back to old during rotation window]
    W -- No --> Y
    X & Y --> Z{High event volume?}
    Z -- Yes --> AA[Write to queue: Redis Streams / SQS / Kafka, process async]
    Z -- No --> AB[Inline processing sufficient]
    AA & AB --> AC([Output: Reliable webhook pipeline with sig verification + DLQ])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
1. Is signature verification constant-time?
2. is idempotency enforced?
3. Are transient errors 500ed?
4. is DLQ implemented?
5. is heavy work async?

## MCP Dependencies
- `@upstash/context7-mcp`: Library documentation and examples.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples/references, added compatibility/license |
| 1.0.0 | 2026-03-20 | Initial release |
