# Example Input: unit-test-generation

## Example 1: TypeScript + Jest — Service with dependency

| Variable | Value |
|----------|-------|
| `{{tech_stack}}` | TypeScript + Jest + ts-jest |
| `{{code_to_test}}` | `OrderService.createOrder(userId, items)` — validates stock, creates order in DB transaction, returns created order |
| `{{context}}` | Prisma ORM, `UserRepository` and `ProductRepository` injected via constructor, errors thrown as custom `AppError` |

---

## Example 2: Python + pytest — Pure function

| Variable | Value |
|----------|-------|
| `{{tech_stack}}` | Python 3.11 + pytest |
| `{{code_to_test}}` | `calculate_discount(price, coupon_code)` — applies percentage or fixed discount based on coupon type |
| `{{context}}` | Returns `Decimal`, raises `InvalidCouponError` for unknown codes, `ExpiredCouponError` for expired ones |
