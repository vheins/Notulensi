# Example Output: memory-management

## Memory Update: decision_made

The following entry was appended to `.agents/memory.md`:

```markdown
## [2026-03-21] Decision: CQRS for Reporting Module

**Type:** decision_made
**Context:** Reporting queries were causing lock contention on the main `orders` table during peak hours.
**Decision:** Adopt CQRS pattern for the reporting module. Read models are maintained as separate projections, updated asynchronously via domain events.
**Impact:**
- `ReportingController` reads from `order_summaries` (read model), not `orders`
- Write path unchanged — `OrderService` still writes to `orders`
- New: `OrderProjectionListener` updates `order_summaries` on `OrderCreated` / `OrderUpdated` events
**Do NOT:** query `orders` table directly from reporting endpoints
```

---

## Memory Update: new_pattern

```markdown
## [2026-03-21] Pattern: Idempotent Background Jobs

**Type:** new_pattern
**Context:** Double-charge incident in production caused by non-idempotent job retried after partial failure.
**Pattern:** All background jobs must:
1. Extend `BaseJob`
2. Implement `handle()` method
3. Be idempotent — check if work is already done before executing
4. Use a `job_id` or `idempotency_key` to detect duplicates
**Established:** After production incident 2026-03-15
```
