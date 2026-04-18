# Example Output: test-coverage-analysis

## Example 1: OrderService with low branch coverage

**Coverage Gap Analysis**

| Branch | Covered? | Test Needed |
|--------|----------|-------------|
| User not found → throw 404 | ❌ | `mockUserRepo.findById.mockResolvedValue(null)` |
| Product not found → throw 404 | ❌ | `mockProductRepo.findByIds` returns fewer items than requested |
| Insufficient stock → throw 422 | ❌ | `product.stock < item.quantity` |
| Payment failure → rollback | ❌ | `mockPaymentGateway.charge` throws |
| Success path | ✅ | Already covered |

**Tests to Add**

```typescript
it('throws 404 when user not found', async () => {
  mockUserRepo.findById.mockResolvedValue(null);
  await expect(service.createOrder('u999', items)).rejects.toMatchObject({ status: 404 });
});

it('throws 404 when product not found', async () => {
  mockProductRepo.findByIds.mockResolvedValue([]); // empty — product missing
  await expect(service.createOrder('u1', items)).rejects.toMatchObject({ status: 404 });
});

it('throws 422 when stock insufficient', async () => {
  mockProductRepo.findByIds.mockResolvedValue([{ id: 'p1', stock: 0 }]);
  await expect(service.createOrder('u1', [{ productId: 'p1', quantity: 1 }]))
    .rejects.toMatchObject({ status: 422 });
});

it('rolls back DB transaction when payment fails', async () => {
  mockPaymentGateway.charge.mockRejectedValue(new Error('Card declined'));
  await expect(service.createOrder('u1', items)).rejects.toThrow('Card declined');
  // Verify no order was persisted
  expect(await prisma.order.count()).toBe(0);
});
```

**Expected coverage after adding tests:** Lines: 95%, Branches: 90%

**Remaining uncovered (acceptable):** Error logging paths, catch-all 500 handler (tested via integration tests).
