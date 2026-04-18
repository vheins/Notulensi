# Example Output: unit-test-generation

## Example 1: TypeScript + Jest — OrderService.createOrder

```typescript
import { OrderService } from '../OrderService';
import { UserRepository } from '../UserRepository';
import { ProductRepository } from '../ProductRepository';
import { AppError } from '../errors';

const mockUserRepo = { findById: jest.fn() };
const mockProductRepo = { findByIds: jest.fn() };
const mockPrisma = { $transaction: jest.fn() };

const service = new OrderService(mockUserRepo as any, mockProductRepo as any, mockPrisma as any);

beforeEach(() => jest.clearAllMocks());

describe('OrderService.createOrder', () => {
  it('creates order when user and products are valid', async () => {
    mockUserRepo.findById.mockResolvedValue({ id: 'u1' });
    mockProductRepo.findByIds.mockResolvedValue([{ id: 'p1', stock: 10, price: 50 }]);
    mockPrisma.$transaction.mockResolvedValue({ id: 'order1', total: 50 });

    const result = await service.createOrder('u1', [{ productId: 'p1', quantity: 1 }]);

    expect(result).toEqual({ id: 'order1', total: 50 });
    expect(mockPrisma.$transaction).toHaveBeenCalledTimes(1);
  });

  it('throws AppError when user not found', async () => {
    mockUserRepo.findById.mockResolvedValue(null);

    await expect(service.createOrder('u999', [{ productId: 'p1', quantity: 1 }]))
      .rejects.toThrow(AppError);
  });

  it('throws AppError when product has insufficient stock', async () => {
    mockUserRepo.findById.mockResolvedValue({ id: 'u1' });
    mockProductRepo.findByIds.mockResolvedValue([{ id: 'p1', stock: 0, price: 50 }]);

    await expect(service.createOrder('u1', [{ productId: 'p1', quantity: 1 }]))
      .rejects.toThrow(AppError);
  });
});
```

---

## Example 2: Python + pytest — calculate_discount

```python
import pytest
from decimal import Decimal
from app.discount import calculate_discount
from app.errors import InvalidCouponError, ExpiredCouponError

def test_percentage_coupon_applies_correctly():
    result = calculate_discount(Decimal("100.00"), "SAVE20")
    assert result == Decimal("80.00")

def test_fixed_coupon_applies_correctly():
    result = calculate_discount(Decimal("100.00"), "FLAT10")
    assert result == Decimal("90.00")

def test_discount_does_not_go_below_zero():
    result = calculate_discount(Decimal("5.00"), "FLAT10")
    assert result == Decimal("0.00")

def test_invalid_coupon_raises_error():
    with pytest.raises(InvalidCouponError):
        calculate_discount(Decimal("100.00"), "NOTREAL")

def test_expired_coupon_raises_error():
    with pytest.raises(ExpiredCouponError):
        calculate_discount(Decimal("100.00"), "EXPIRED2023")
```
