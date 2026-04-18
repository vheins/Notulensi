# Example Output: flaky-test-diagnosis

## Example 1: Flaky integration test

**Root Cause: Async timing — asserting before background job executes**

The test asserts `emailMock` was called immediately after the HTTP response, but the email is dispatched via BullMQ (async). The job may not have been processed yet when the assertion runs. In CI with 4 parallel workers, the event loop is busier, making the race condition more likely.

**Fix: Wait for the async side effect**

```typescript
// ❌ Before — race condition
it('sends welcome email after registration', async () => {
  await request(app).post('/register').send({ email: 'test@example.com', password: 'Pass123!' });
  expect(emailMock).toHaveBeenCalledTimes(1); // job may not have run yet
});

// ✅ After — wait for job to process
it('sends welcome email after registration', async () => {
  await request(app).post('/register').send({ email: 'test@example.com', password: 'Pass123!' });

  // Wait for BullMQ job to be processed (poll with timeout)
  await waitFor(() => expect(emailMock).toHaveBeenCalledTimes(1), { timeout: 3000 });
});

// Helper
async function waitFor(assertion: () => void, { timeout = 2000, interval = 100 } = {}) {
  const deadline = Date.now() + timeout;
  while (Date.now() < deadline) {
    try { assertion(); return; } catch {}
    await new Promise(r => setTimeout(r, interval));
  }
  assertion(); // final attempt — throws if still failing
}
```

**Alternative: Use in-process queue for tests**

```typescript
// In test setup — use synchronous/in-memory queue instead of Redis
jest.mock('../queue', () => ({
  add: jest.fn().mockImplementation(async (name, data) => {
    await processJob(name, data); // execute synchronously in tests
  }),
}));
```

**Why it only fails in CI:** CI runs 4 Jest workers in parallel → higher CPU contention → event loop delays → job processing takes longer → assertion fires before job runs.
