# Example Output: e2e-test-scenario-writing

## Example 1: User checkout flow

```typescript
import { test, expect } from '@playwright/test';

test.describe('Checkout flow', () => {
  test.beforeEach(async ({ page }) => {
    // Login as test user
    await page.goto('/login');
    await page.fill('[name=email]', 'test@example.com');
    await page.fill('[name=password]', 'TestPass123!');
    await page.click('button[type=submit]');
    await expect(page).toHaveURL('/dashboard');
  });

  test('completes full checkout and shows order confirmation', async ({ page }) => {
    // Browse and add to cart
    await page.goto('/products');
    await page.click('[data-testid="product-card"]:first-child');
    await page.click('[data-testid="add-to-cart"]');
    await expect(page.locator('[data-testid="cart-count"]')).toHaveText('1');

    // Proceed to checkout
    await page.click('[data-testid="cart-icon"]');
    await page.click('[data-testid="checkout-btn"]');
    await expect(page).toHaveURL('/checkout/shipping');

    // Fill shipping info
    await page.fill('[name=fullName]', 'Test User');
    await page.fill('[name=address]', '123 Test St');
    await page.fill('[name=city]', 'San Francisco');
    await page.fill('[name=zip]', '94105');
    await page.click('[data-testid="continue-to-payment"]');

    // Fill Stripe test card (iframe)
    const stripeFrame = page.frameLocator('iframe[name*="stripe"]').first();
    await stripeFrame.locator('[placeholder="Card number"]').fill('4242424242424242');
    await stripeFrame.locator('[placeholder="MM / YY"]').fill('12/28');
    await stripeFrame.locator('[placeholder="CVC"]').fill('123');

    await page.click('[data-testid="place-order"]');

    // Verify confirmation
    await expect(page).toHaveURL(/\/orders\/[a-z0-9-]+\/confirmation/);
    await expect(page.locator('[data-testid="order-status"]')).toHaveText('Order Confirmed');
    await expect(page.locator('[data-testid="order-id"]')).toBeVisible();
  });

  test('shows error for declined card', async ({ page }) => {
    await page.goto('/checkout/payment');
    const stripeFrame = page.frameLocator('iframe[name*="stripe"]').first();
    await stripeFrame.locator('[placeholder="Card number"]').fill('4000000000000002'); // decline card
    await stripeFrame.locator('[placeholder="MM / YY"]').fill('12/28');
    await stripeFrame.locator('[placeholder="CVC"]').fill('123');
    await page.click('[data-testid="place-order"]');

    await expect(page.locator('[data-testid="payment-error"]')).toContainText('declined');
    await expect(page).toHaveURL('/checkout/payment'); // stays on payment page
  });
});
```
