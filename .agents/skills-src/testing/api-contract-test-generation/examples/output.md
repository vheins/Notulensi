# Example Output: api-contract-test-generation

## Example 1: Orders API — POST /orders

```typescript
import request from 'supertest';
import app from '../app';
import { generateTestToken } from './helpers/auth';
import { seedUser, seedProduct, cleanDb } from './helpers/db';

const token = generateTestToken({ userId: 'u1', role: 'user' });

beforeEach(cleanDb);

describe('POST /api/v1/orders — contract', () => {
  it('201: returns created order matching contract', async () => {
    await seedUser({ id: 'u1' });
    await seedProduct({ id: 'p1', stock: 10, price: 50 });

    const res = await request(app)
      .post('/api/v1/orders')
      .set('Authorization', `Bearer ${token}`)
      .send({ userId: 'u1', items: [{ productId: 'p1', quantity: 2 }] });

    expect(res.status).toBe(201);
    expect(res.body).toMatchObject({
      id: expect.any(String),
      userId: 'u1',
      total: expect.any(Number),
      items: expect.arrayContaining([
        expect.objectContaining({ productId: 'p1', quantity: 2 }),
      ]),
    });
  });

  it('400: returns error contract on validation failure', async () => {
    const res = await request(app)
      .post('/api/v1/orders')
      .set('Authorization', `Bearer ${token}`)
      .send({ userId: 'u1', items: [] }); // empty items

    expect(res.status).toBe(400);
    expect(res.body).toMatchObject({ error: expect.any(String) });
  });

  it('404: returns error contract when user not found', async () => {
    const res = await request(app)
      .post('/api/v1/orders')
      .set('Authorization', `Bearer ${token}`)
      .send({ userId: 'nonexistent', items: [{ productId: 'p1', quantity: 1 }] });

    expect(res.status).toBe(404);
    expect(res.body).toMatchObject({ error: expect.any(String) });
  });

  it('401: returns 401 without auth token', async () => {
    const res = await request(app)
      .post('/api/v1/orders')
      .send({ userId: 'u1', items: [{ productId: 'p1', quantity: 1 }] });

    expect(res.status).toBe(401);
  });
});
```
