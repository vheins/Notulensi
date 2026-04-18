# Example Output: database-migration-test

## Example 1: Add status column to orders table

**Migration Test Plan**

```typescript
// tests/migrations/add-status-to-orders.test.ts
import { PrismaClient } from '@prisma/client';
import { execSync } from 'child_process';

const prisma = new PrismaClient();

beforeAll(async () => {
  // Apply migration to test DB
  execSync('npx prisma migrate deploy', { env: { ...process.env, DATABASE_URL: process.env.TEST_DATABASE_URL } });
});

afterAll(() => prisma.$disconnect());

describe('Migration: add status to orders', () => {
  it('column exists with correct type and default', async () => {
    const result = await prisma.$queryRaw`
      SELECT column_name, data_type, column_default
      FROM information_schema.columns
      WHERE table_name = 'orders' AND column_name = 'status'
    `;
    expect(result[0]).toMatchObject({
      column_name: 'status',
      column_default: expect.stringContaining('pending'),
    });
  });

  it('backfill: orders with payment_id have status=paid', async () => {
    const unpaid = await prisma.$queryRaw`
      SELECT COUNT(*) as count FROM orders
      WHERE payment_id IS NOT NULL AND status != 'paid'
    `;
    expect(Number(unpaid[0].count)).toBe(0);
  });

  it('backfill: orders without payment_id have status=pending', async () => {
    const wrong = await prisma.$queryRaw`
      SELECT COUNT(*) as count FROM orders
      WHERE payment_id IS NULL AND status != 'pending'
    `;
    expect(Number(wrong[0].count)).toBe(0);
  });

  it('no rows have NULL status after migration', async () => {
    const nullRows = await prisma.$queryRaw`
      SELECT COUNT(*) as count FROM orders WHERE status IS NULL
    `;
    expect(Number(nullRows[0].count)).toBe(0);
  });

  it('new orders default to pending status', async () => {
    const order = await prisma.order.create({ data: { userId: 'test-user' } });
    expect(order.status).toBe('pending');
    await prisma.order.delete({ where: { id: order.id } });
  });
});
```

**Rollback Verification**
```sql
-- After running down migration:
SELECT column_name FROM information_schema.columns
WHERE table_name = 'orders' AND column_name = 'status';
-- Expected: 0 rows (column removed)
```
