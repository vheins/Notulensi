# Example Output: async-await-error-tracing

**Expected Output Shape:**
```
1. Async Error Classification
Unhandled promise rejection — Express route handler is async but Express 4.x does not automatically catch async errors. The rejected promise propagates to the Node.js process unhandled.

2. Error Flow Trace
db.query() rejects → await throws → async route handler rejects → Express does not catch → UnhandledPromiseRejection

3. Fix
Before:
  app.get('/users', async (req, res) => {
    const users = await db.query('SELECT * FROM users');
    res.json(users);
  });

After (explicit try/catch):
  app.get('/users', async (req, res, next) => {
    try {
      const users = await db.query('SELECT * FROM users');
      res.json(users);
    } catch (err) {
      next(err);  // pass to Express error middleware
    }
  });

// Or use express-async-errors package for automatic async error handling:
  require('express-async-errors');
  app.get('/users', async (req, res) => {
    const users = await db.query('SELECT * FROM users');
    res.json(users);
  });

4. Async Stack Trace
node --async-stack-traces app.js  // enables full async stack traces in Node 12+

5. Test
it('returns 500 when DB is unavailable', async () => {
  jest.spyOn(db, 'query').mockRejectedValue(new Error('ECONNREFUSED'));
  const res = await request(app).get('/users');
  expect(res.status).toBe(500);
});
```


**Expected Output Shape:**
```
1. Async Error Classification
Promise swallowing — the .catch() handler logs the error but does not update component state, leaving the UI in a loading/blank state with no user feedback.

2. Error Flow Trace
fetchUser(id) rejects → .catch(err => console.log(err)) catches → error logged but not surfaced → UI state unchanged → blank screen

3. Fix
Before:
  fetchUser(id).then(setUser).catch(err => console.log(err));

After (error state):
  fetchUser(id)
    .then(setUser)
    .catch(err => {
      console.error('Failed to fetch user:', err);
      setError(err.message);  // update error state for UI display
    });

// With async/await for clarity:
  useEffect(() => {
    let cancelled = false;
    async function load() {
      try {
        const user = await fetchUser(id);
        if (!cancelled) setUser(user);
      } catch (err) {
        if (!cancelled) setError(err instanceof Error ? err.message : 'Unknown error');
      }
    }
    load();
    return () => { cancelled = true; };  // cleanup for unmount
  }, [id]);

4. Async Stack Trace
Enable React DevTools Profiler to trace async state updates.
Use React Query or SWR for built-in error state management.

5. Test
it('shows error message when fetch fails', async () => {
  server.use(rest.get('/api/user/:id', (req, res, ctx) => res(ctx.status(401))));
  render(<UserCard id="1" />);
  expect(await screen.findByText(/unauthorized/i)).toBeInTheDocument();
});
```
