# References: deep-audit

## Layer Separation Principles

- **Controller/Route Handler** — thin delegation only, no business logic
- **Service/Use Case** — all business logic, domain rules, calculations
- **Observer/Event Handler** — side effects after entity events
- **Database/Persistence** — constraints, integrity, cascades

Violation: any logic found outside its designated layer.

## N+1 Query Pattern

An N+1 occurs when a loop executes one query per iteration instead of a single batched query.

**Detection:** Look for ORM calls inside `for`/`forEach`/`map` loops.

**Fix pattern:**
```
// N+1 (bad)
for item in items:
    product = db.find(item.product_id)

// Batched (good)
ids = [item.product_id for item in items]
products = db.find_many(ids)
product_map = {p.id: p for p in products}
```

## Coding Standards Reference

See `.agents/rules/coding-standards.md` for the full standards checklist.
See `.agents/rules/business-logic.md` for layer separation patterns.
