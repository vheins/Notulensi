# Example Output: deep-audit

## Audit Report: OrderManagement (Node.js + Express + TypeScript + Prisma)

### Layer Violations

| File | Violation | Severity | Fix |
|------|-----------|----------|-----|
| `OrderController.ts:42` | Business logic (discount calc) in controller | High | Move to `OrderService.calculateDiscount()` |
| `OrderController.ts:78` | Direct Prisma query in controller | High | Move to `OrderRepository.findByUser()` |
| `OrderRouter.ts:15` | Validation logic inline in route | Medium | Extract to `validateCreateOrder` middleware |

### N+1 Query Patterns

| File | Line | Pattern | Fix |
|------|------|---------|-----|
| `OrderService.ts:55` | Loop calling `prisma.product.findUnique()` per item | N+1 | Replace with `prisma.product.findMany({ where: { id: { in: ids } } })` |

### Coding Standard Violations

- `order.service.ts` — missing return type annotations on 3 methods
- `OrderController.ts` — `any` type used in 2 places

### Summary

| Category | Count | Critical |
|----------|-------|---------|
| Layer violations | 3 | 2 |
| N+1 queries | 1 | 1 |
| Standard violations | 2 | 0 |

### Recommended Refactor Order

1. Extract Prisma calls from controller → `OrderRepository`
2. Move discount logic → `OrderService`
3. Fix N+1 in `OrderService.ts:55`
4. Add return types and remove `any`
