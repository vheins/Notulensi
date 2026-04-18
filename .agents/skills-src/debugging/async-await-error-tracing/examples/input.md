# Example Input: async-await-error-tracing

### Example 1: Node.js + Express — Unhandled Promise Rejection
**Input:**
- `{{tech_stack}}`: Node.js + Express
- `{{error_message}}`: `UnhandledPromiseRejectionWarning: Error: connect ECONNREFUSED 127.0.0.1:5432`
- `{{code}}`: `app.get('/users', async (req, res) => { const users = await db.query('SELECT * FROM users'); res.json(users); });`
- `{{context}}`: Route handler queries the database; if DB is down, the promise rejects but Express does not catch async errors automatically


### Example 2: TypeScript + React — Promise Swallowing in useEffect
**Input:**
- `{{tech_stack}}`: TypeScript + React
- `{{error_message}}`: No error shown in UI; data never loads; console shows no errors
- `{{code}}`: `useEffect(() => { fetchUser(id).then(setUser).catch(err => console.log(err)); }, [id]);`
- `{{context}}`: fetchUser rejects with a 401 error; the catch logs it but does not update UI state; user sees blank screen
