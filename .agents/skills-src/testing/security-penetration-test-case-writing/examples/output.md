# Example Output: security-penetration-test-case-writing

## Example 1: REST API with JWT auth

**IDOR (Insecure Direct Object Reference)**

```typescript
it('SEC-001: user cannot access another user\'s profile', async () => {
  const user1Token = generateToken({ userId: 'u1', role: 'user' });
  const res = await request(app)
    .get('/api/users/u2') // accessing u2's data with u1's token
    .set('Authorization', `Bearer ${user1Token}`);
  expect(res.status).toBe(403);
});

it('SEC-002: user cannot access another user\'s orders', async () => {
  const user1Token = generateToken({ userId: 'u1', role: 'user' });
  const res = await request(app)
    .get('/api/orders?userId=u2')
    .set('Authorization', `Bearer ${user1Token}`);
  expect(res.status).toBe(403);
  // Ensure no u2 orders leaked in response
  expect(JSON.stringify(res.body)).not.toContain('u2');
});
```

**Broken Authentication**

```typescript
it('SEC-003: expired JWT is rejected', async () => {
  const expiredToken = generateToken({ userId: 'u1' }, { expiresIn: '-1s' });
  const res = await request(app)
    .get('/api/users/u1')
    .set('Authorization', `Bearer ${expiredToken}`);
  expect(res.status).toBe(401);
});

it('SEC-004: tampered JWT signature is rejected', async () => {
  const token = generateToken({ userId: 'u1' });
  const tampered = token.slice(0, -5) + 'XXXXX';
  const res = await request(app)
    .get('/api/users/u1')
    .set('Authorization', `Bearer ${tampered}`);
  expect(res.status).toBe(401);
});

it('SEC-005: admin endpoint rejects non-admin JWT', async () => {
  const userToken = generateToken({ userId: 'u1', role: 'user' });
  const res = await request(app)
    .get('/api/admin/users')
    .set('Authorization', `Bearer ${userToken}`);
  expect(res.status).toBe(403);
});
```

**SQL Injection**

```typescript
it('SEC-006: SQL injection in user ID param is handled safely', async () => {
  const token = generateToken({ userId: 'u1', role: 'admin' });
  const res = await request(app)
    .get("/api/users/1' OR '1'='1")
    .set('Authorization', `Bearer ${token}`);
  // Should return 404 (not found) or 400 (invalid ID), never 200 with all users
  expect([400, 404]).toContain(res.status);
  expect(Array.isArray(res.body)).toBe(false);
});
```

**Security Headers**

```typescript
it('SEC-007: security headers are present', async () => {
  const res = await request(app).get('/api/products');
  expect(res.headers['x-content-type-options']).toBe('nosniff');
  expect(res.headers['x-frame-options']).toBeDefined();
  expect(res.headers['strict-transport-security']).toBeDefined();
});
```
