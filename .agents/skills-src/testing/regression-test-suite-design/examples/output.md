# Example Output: regression-test-suite-design

## Example 1: E-commerce platform

**Regression Test Suite Structure**

```
tests/
├── unit/           # 200 tests — run on every commit (<30s)
├── integration/    # 60 tests — run on every PR (<5min)
├── e2e/            # 25 tests — run pre-release (<15min)
└── regression/     # bug-specific tests — run on every PR
    ├── BUG-101-discount-stacking.test.ts
    ├── BUG-102-empty-cart-checkout.test.ts
    └── BUG-103-password-reset-timezone.test.ts
```

**Bug Regression Tests**

```typescript
// regression/BUG-101-discount-stacking.test.ts
it('[BUG-101] order total is correct when multiple discounts applied', async () => {
  // $100 product, 10% coupon + $5 flat coupon
  const total = calculateOrderTotal({ price: 100, coupons: ['SAVE10', 'FLAT5'] });
  expect(total).toBe(85); // 100 - 10% = 90, then 90 - 5 = 85
  // Previously returned 80 (applied both to original price)
});

// regression/BUG-102-empty-cart-checkout.test.ts
it('[BUG-102] checkout rejects empty cart with 400', async () => {
  const res = await request(app)
    .post('/api/checkout')
    .set('Authorization', `Bearer ${token}`)
    .send({ items: [] });
  expect(res.status).toBe(400);
  expect(res.body.error).toMatch(/cart.*empty/i);
});

// regression/BUG-103-password-reset-timezone.test.ts
it('[BUG-103] password reset token valid for 1 hour regardless of server timezone', () => {
  const timezones = ['UTC', 'America/New_York', 'Asia/Tokyo', 'Australia/Sydney'];
  for (const tz of timezones) {
    process.env.TZ = tz;
    const token = generateResetToken();
    const isValid = validateResetToken(token, Date.now() + 30 * 60 * 1000); // 30min later
    expect(isValid).toBe(true);
  }
});
```

**Critical Path E2E Regression Tests**

| Test | Covers | Framework |
|------|--------|-----------|
| Full checkout flow | BUG-102 + payment | Playwright |
| Discount application | BUG-101 | Jest integration |
| Password reset flow | BUG-103 | Playwright |
| User registration → login | auth regression | Playwright |
