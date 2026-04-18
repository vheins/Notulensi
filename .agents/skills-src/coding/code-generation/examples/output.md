# Example Output: code-generation

### Example 1: TypeScript + Express + PostgreSQL

**Expected Output:**
```typescript
// POST /users — Register a new user
// Validates email, hashes password, persists to DB, returns sanitized user
router.post('/users', async (req: Request, res: Response) => {
  const { email, password } = req.body;

  // Validate email format before any DB interaction
  if (!email || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
    return res.status(400).json({ error: 'Invalid email format', code: 'INVALID_EMAIL' });
  }

  if (!password || password.length < 8) {
    return res.status(400).json({ error: 'Password must be at least 8 characters', code: 'WEAK_PASSWORD' });
  }

  try {
    // Check for duplicate email before hashing (cheaper operation first)
    const existing = await db.query('SELECT id FROM users WHERE email = $1', [email]);
    if (existing.rows.length > 0) {
      return res.status(409).json({ error: 'Email already registered', code: 'DUPLICATE_EMAIL' });
    }

    // bcrypt cost factor 12 — balances security vs. latency (~300ms on modern hardware)
    const password_hash = await bcrypt.hash(password, 12);
    const result = await db.query(
      'INSERT INTO users (email, password_hash) VALUES ($1, $2) RETURNING id, email, created_at',
      [email, password_hash]
    );

    return res.status(201).json(result.rows[0]);
  } catch (err) {
    // Log full error internally, return generic message to client
    console.error('[POST /users] DB error:', err);
    return res.status(500).json({ error: 'Internal server error', code: 'DB_ERROR' });
  }
});
```

Self-Review Checklist:
1. ✅ Error paths: invalid email, weak password, duplicate, DB failure all handled
2. ⚠️ bcrypt cost factor 12 is hardcoded — consider moving to config
3. ✅ No SQL injection — parameterized queries used
4. ✅ Password hash never returned in response
5. ✅ Matches existing error response shape `{ error, code }`
6. ⚠️ No rate limiting on this endpoint — consider adding for production

---

### Example 2: Python + FastAPI + SQLAlchemy

**Expected Output:**
```python
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session, joinedload
from app.database import get_db
from app.models import Product, Category
from app.schemas import ProductResponse

router = APIRouter()

@router.get("/products/{product_id}", response_model=ProductResponse)
def get_product(product_id: int, db: Session = Depends(get_db)):
    # Use joinedload to avoid N+1 query — fetches category in same SQL query
    product = (
        db.query(Product)
        .options(joinedload(Product.category))
        .filter(Product.id == product_id)
        .first()
    )

    if product is None:
        # 404 with descriptive detail for API consumers
        raise HTTPException(status_code=404, detail=f"Product {product_id} not found")

    return product
```

Self-Review Checklist:
1. ✅ 404 handled explicitly
2. ✅ No hardcoded values
3. ✅ No SQL injection — ORM parameterizes queries
4. ✅ DB session managed via dependency injection (auto-closed)
5. ✅ joinedload prevents N+1 query
6. ✅ response_model ensures no unexpected fields leak
