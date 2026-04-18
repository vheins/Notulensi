# Example Input: mutation-testing-guidance

## Example 1: Discount calculation module

| Variable | Value |
|----------|-------|
| `{{tech_stack}}` | TypeScript + Stryker |
| `{{code_context}}` | `src/utils/discount.ts` — `calculateDiscount(price, coupon)` with percentage/fixed logic and boundary checks |
| `{{mutation_score}}` | Not yet run. Current line coverage: 90%, but team suspects branch coverage is weak. |
