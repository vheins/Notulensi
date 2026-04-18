# Example Input: mock-stub-generation

## Example 1: Payment gateway mock

| Variable | Value |
|----------|-------|
| `{{dependency_interface}}` | `PaymentGateway` interface with methods: `charge(amount, currency, token): Promise<{transactionId, status}>`, `refund(transactionId): Promise<void>`, `getStatus(transactionId): Promise<string>` |
| `{{tech_stack}}` | TypeScript + Jest |
| `{{mock_behavior}}` | Success by default; also need scenarios for declined card, network error, and partial failure (charge succeeds, refund fails) |
