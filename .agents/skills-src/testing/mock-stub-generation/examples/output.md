# Example Output: mock-stub-generation

## Example 1: Payment gateway mock

```typescript
// tests/mocks/PaymentGateway.mock.ts
import { PaymentGateway } from '../../src/interfaces/PaymentGateway';

export const createMockPaymentGateway = (): jest.Mocked<PaymentGateway> => ({
  charge: jest.fn().mockResolvedValue({ transactionId: 'txn_test_123', status: 'succeeded' }),
  refund: jest.fn().mockResolvedValue(undefined),
  getStatus: jest.fn().mockResolvedValue('succeeded'),
});

// Scenario helpers
export const mockDeclinedCard = (mock: jest.Mocked<PaymentGateway>) => {
  mock.charge.mockRejectedValueOnce(new Error('Card declined'));
};

export const mockNetworkError = (mock: jest.Mocked<PaymentGateway>) => {
  mock.charge.mockRejectedValueOnce(new Error('Network timeout'));
  mock.refund.mockRejectedValueOnce(new Error('Network timeout'));
  mock.getStatus.mockRejectedValueOnce(new Error('Network timeout'));
};

export const mockRefundFailure = (mock: jest.Mocked<PaymentGateway>) => {
  // charge succeeds, refund fails
  mock.charge.mockResolvedValueOnce({ transactionId: 'txn_test_456', status: 'succeeded' });
  mock.refund.mockRejectedValueOnce(new Error('Refund failed: transaction not found'));
};

// Usage in tests:
describe('OrderService', () => {
  let paymentGateway: jest.Mocked<PaymentGateway>;

  beforeEach(() => {
    paymentGateway = createMockPaymentGateway();
  });

  it('processes payment successfully', async () => {
    const service = new OrderService(paymentGateway);
    const result = await service.checkout({ amount: 100, currency: 'USD', token: 'tok_test' });
    expect(paymentGateway.charge).toHaveBeenCalledWith(100, 'USD', 'tok_test');
    expect(result.status).toBe('paid');
  });

  it('handles declined card', async () => {
    mockDeclinedCard(paymentGateway);
    const service = new OrderService(paymentGateway);
    await expect(service.checkout({ amount: 100, currency: 'USD', token: 'tok_declined' }))
      .rejects.toThrow('Card declined');
  });
});
```
