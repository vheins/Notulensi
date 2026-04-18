# Example Input: test-coverage-analysis

## Example 1: OrderService with low branch coverage

| Variable | Value |
|----------|-------|
| `{{code_context}}` | `OrderService.createOrder` — 5 branches: user not found, product not found, insufficient stock, payment failure, success |
| `{{existing_tests}}` | Only happy path test exists. Coverage report: 85% lines, 40% branches. |
| `{{tech_stack}}` | TypeScript + Jest |
