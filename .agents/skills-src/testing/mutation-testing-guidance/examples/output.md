# Example Output: mutation-testing-guidance

## Example 1: Discount calculation module

**Stryker Config**

```json
// stryker.config.json
{
  "mutate": ["src/utils/discount.ts"],
  "testRunner": "jest",
  "reporters": ["html", "clear-text"],
  "thresholds": { "high": 80, "low": 60, "break": 50 },
  "coverageAnalysis": "perTest"
}
```

Run: `npx stryker run`

---

**Likely Surviving Mutants (based on 90% line coverage)**

| Mutant | Original | Mutated | Why it survives |
|--------|----------|---------|-----------------|
| Boundary | `price > 0` | `price >= 0` | No test for `price === 0` |
| Arithmetic | `price * (1 - rate)` | `price * (1 + rate)` | No test verifying exact discounted value |
| Conditional | `coupon.type === 'percentage'` | `coupon.type !== 'percentage'` | Only one coupon type tested |
| Return value | `return discounted` | `return 0` | No assertion on return value in some tests |

---

**Tests to Add to Kill Surviving Mutants**

```typescript
it('returns 0 when price is 0', () => {
  expect(calculateDiscount(0, validCoupon)).toBe(0);
});

it('applies exactly 20% discount on $100', () => {
  expect(calculateDiscount(100, { type: 'percentage', value: 20 })).toBe(80);
});

it('applies fixed $10 discount on $100', () => {
  expect(calculateDiscount(100, { type: 'fixed', value: 10 })).toBe(90);
});

it('does not apply percentage logic to fixed coupon', () => {
  const result = calculateDiscount(50, { type: 'fixed', value: 10 });
  expect(result).toBe(40); // not 50 * (1 - 10) = -450
});
```

**Expected mutation score after fixes: ~85%**
