# Example Output: brainstorm-feature

## Technical Design Brief: Multi-Currency Payment

### Problem Statement
Users in non-USD markets see foreign prices and abandon checkout. Adding multi-currency support reduces friction and increases conversion in 15 target markets.

### Proposed Approach
Store prices in a base currency (USD). At display and checkout time, convert using cached exchange rates. Stripe handles currency-specific payment processing natively.

### Key Components

| Component | Responsibility |
|-----------|---------------|
| `CurrencyService` | Fetch + cache exchange rates (daily refresh via cron) |
| `PriceFormatter` | Convert + format prices for display per locale |
| `CheckoutService` | Pass currency code to Stripe PaymentIntent |
| `ExchangeRateTable` | Store daily rates with effective date |

### Data Model Changes
- Add `currency_code` (VARCHAR 3) to `orders` table
- Add `exchange_rate` (DECIMAL 15,6) to `orders` table — snapshot rate at time of purchase
- New table: `exchange_rates(currency_code, rate, effective_date)`

### Integration Points
- Stripe: use `currency` param on PaymentIntent — no breaking change to USD flow
- Exchange rate source: Open Exchange Rates API (daily cron job)

### Risks & Mitigations

| Risk | Mitigation |
|------|-----------|
| Stale exchange rates | Cache with TTL + fallback to last known rate |
| Rounding errors | Always round to 2 decimal places at display, not storage |
| Stripe currency support gaps | Validate currency against Stripe's supported list before checkout |

### Implementation Order
1. `exchange_rates` table + `CurrencyService`
2. `PriceFormatter` + display layer
3. `CheckoutService` Stripe integration
4. Migration: add `currency_code` + `exchange_rate` to `orders`
