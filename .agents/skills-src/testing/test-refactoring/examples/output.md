# Example Output: test-refactoring

## Example 1: Brittle, duplicated test suite

**Before (problematic)**

```typescript
describe('test 1', () => {
  beforeEach(() => {
    // 50 lines of setup duplicated in 3 describe blocks
    mockUserRepo.findById.mockResolvedValue({ id: 'user123', role: 'user' });
    mockOrderRepo.create.mockResolvedValue({ id: 'order456' });
    // ... 48 more lines
  });

  it('should work', async () => {
    await service.createOrder('user123', items);
    expect(mockOrderRepo.create).toHaveBeenCalledTimes(1); // testing implementation
  });
});
```

**After (refactored)**

```typescript
// tests/helpers/setup.ts — shared setup extracted
export const createTestContext = () => {
  const mockUserRepo = { findById: jest.fn() };
  const mockOrderRepo = { create: jest.fn() };

  beforeEach(() => {
    jest.clearAllMocks();
    mockUserRepo.findById.mockResolvedValue(UserFactory.build({ id: 'u1' }));
    mockOrderRepo.create.mockResolvedValue(OrderFactory.build({ id: 'o1' }));
  });

  return { mockUserRepo, mockOrderRepo };
};

// OrderService.test.ts
describe('OrderService', () => {
  const { mockUserRepo, mockOrderRepo } = createTestContext();
  const service = new OrderService(mockUserRepo, mockOrderRepo);

  describe('createOrder', () => {
    it('returns created order when user and items are valid', async () => {
      // Test behavior, not implementation
      const result = await service.createOrder('u1', [{ productId: 'p1', quantity: 1 }]);
      expect(result).toMatchObject({ id: expect.any(String) });
    });

    it('throws NotFoundError when user does not exist', async () => {
      mockUserRepo.findById.mockResolvedValue(null);
      await expect(service.createOrder('u999', items)).rejects.toThrow(NotFoundError);
    });
  });
});
```

**Changes made:**
1. Extracted shared `beforeEach` to `createTestContext()` helper — used in all 3 describe blocks
2. Replaced magic string `'user123'` with `UserFactory.build({ id: 'u1' })`
3. Changed `expect(mock).toHaveBeenCalledTimes(1)` → `expect(result).toMatchObject(...)` (behavior, not implementation)
4. Renamed `'test 1'` → `'OrderService'`, `'should work'` → `'returns created order when user and items are valid'`
