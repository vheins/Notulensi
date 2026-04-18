# Example Output: code-migration

### Example 1: JavaScript + Express 4 → TypeScript + Express 5

**Expected Output:**
```typescript
// Migrated to TypeScript + Express 5 + Mongoose 8
// Key changes: callback API → async/await, require → import, added types

import { Router, Request, Response, NextFunction } from 'express';
import User, { IUser } from './models/User';

const router = Router();

// Express 5 natively handles async errors — no need for try/catch wrapper
router.get('/users/:id', async (req: Request, res: Response) => {
  const user = await User.findById(req.params.id);
  if (!user) {
    return res.status(404).json({ message: 'Not found' });
  }
  res.json(user);
});

export default router;
```

Breaking Changes Report:
1. Callback-style Mongoose API removed in Mongoose 8 — all queries now return Promises
2. Express 5 async error handling: thrown errors propagate to error middleware automatically
3. `module.exports` → `export default` — update all import sites

Migration Checklist:
1. Update tsconfig.json to include this file's directory
2. Add IUser interface to User model file
3. Update all `require('./routes/users')` to `import usersRouter from './routes/users'`
4. Verify error middleware handles async errors (Express 5 behavior change)

---

### Example 2: Python 2.7 + Flask → Python 3.11 + FastAPI

**Expected Output:**
```python
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

app = FastAPI()

class CalculateRequest(BaseModel):
    a: float
    b: float

@app.post("/calculate")
def calculate(body: CalculateRequest):
    # FastAPI + Pydantic handles missing field validation automatically (422 response)
    if body.b == 0:
        raise HTTPException(status_code=422, detail="Division by zero")
    return {"result": body.a / body.b}
```

Breaking Changes Report:
1. Validation moved to Pydantic model — missing fields now return 422 (not 400) with structured error
2. Python 3 integer division: `5/2 = 2.5` (was `2` in Python 2) — use `float` types in model
3. Flask `jsonify` → FastAPI returns dicts directly (auto-serialized)

Migration Checklist:
1. Install FastAPI and uvicorn: `pip install fastapi uvicorn pydantic`
2. Update all callers to handle 422 validation errors (new error format)
3. Run tests with Python 3.11 to catch any integer division behavior changes
4. Update WSGI server config to ASGI (uvicorn/gunicorn with uvicorn worker)
