# Example Output: smoke-test-suite

## Example 1: SaaS API after deployment

```typescript
// tests/smoke/smoke.test.ts
import request from 'supertest';

const BASE = process.env.SMOKE_BASE_URL || 'https://staging.example.com';
const SMOKE_TOKEN = process.env.SMOKE_TOKEN!; // pre-generated long-lived test token

describe('Smoke Tests — staging', () => {
  it('health check returns 200', async () => {
    const res = await request(BASE).get('/health');
    expect(res.status).toBe(200);
    expect(res.body.status).toBe('ok');
  }, 5000);

  it('database is reachable (health check includes db)', async () => {
    const res = await request(BASE).get('/health/detailed');
    expect(res.status).toBe(200);
    expect(res.body.database).toBe('connected');
    expect(res.body.redis).toBe('connected');
  }, 5000);

  it('auth: login returns JWT token', async () => {
    const res = await request(BASE)
      .post('/api/auth/login')
      .send({ email: 'smoke@example.com', password: process.env.SMOKE_PASSWORD });
    expect(res.status).toBe(200);
    expect(res.body.token).toBeDefined();
  }, 5000);

  it('projects: list returns 200 with array', async () => {
    const res = await request(BASE)
      .get('/api/projects')
      .set('Authorization', `Bearer ${SMOKE_TOKEN}`);
    expect(res.status).toBe(200);
    expect(Array.isArray(res.body.data)).toBe(true);
  }, 5000);

  it('billing: subscription status is accessible', async () => {
    const res = await request(BASE)
      .get('/api/billing/subscription')
      .set('Authorization', `Bearer ${SMOKE_TOKEN}`);
    expect([200, 404]).toContain(res.status); // 404 ok if no subscription yet
  }, 5000);
});
```

Run: `SMOKE_BASE_URL=https://staging.example.com SMOKE_TOKEN=xxx npx jest tests/smoke --testTimeout=10000`

**Pass criteria:** All 5 tests pass in < 30 seconds. Any failure blocks deployment promotion.
