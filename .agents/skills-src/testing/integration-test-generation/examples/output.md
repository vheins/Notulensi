# Example Output: integration-test-generation

## Example 1: Order creation API endpoint

```typescript
import request from 'supertest';
import app from '../app';
import { prisma } from '../db';
import { generateToken } from './helpers/auth';

const token = generateToken({ userId: 'u1' });

beforeEach(async () => {
  await prisma.orderItem.deleteMany();
  await prisma.order.deleteMany();
  await prisma.product.deleteMany();
  await prisma.user.deleteMany();
  await prisma.user.create({ data: { id: 'u1', email: 'test@example.com' } });
  await prisma.product.create({ data: { id: 'p1', name: 'Widget', price: 50, stock: 10 } });
});

afterAll(() => prisma.$disconnect());

describe('POST /api/orders — integration', () => {
  it('creates order and persists to DB', async () => {
    const res = await request(app)
      .post('/api/orders')
      .set('Authorization', `Bearer ${token}`)
      .send({ userId: 'u1', items: [{ productId: 'p1', quantity: 2 }] });

    expect(res.status).toBe(201);
    expect(res.body.id).toBeDefined();

    // Verify DB state
    const order = await prisma.order.findUnique({
      where: { id: res.body.id },
      include: { items: true },
    });
    expect(order).not.toBeNull();
    expect(order!.items).toHaveLength(1);
    expect(order!.items[0].quantity).toBe(2);

    // Verify stock decremented
    const product = await prisma.product.findUnique({ where: { id: 'p1' } });
    expect(product!.stock).toBe(8);
  });

  it('returns 422 and does not create order when stock insufficient', async () => {
    await prisma.product.update({ where: { id: 'p1' }, data: { stock: 0 } });

    const res = await request(app)
      .post('/api/orders')
      .set('Authorization', `Bearer ${token}`)
      .send({ userId: 'u1', items: [{ productId: 'p1', quantity: 1 }] });

    expect(res.status).toBe(422);
    const orderCount = await prisma.order.count();
    expect(orderCount).toBe(0); // no partial order created
  });
});
```
