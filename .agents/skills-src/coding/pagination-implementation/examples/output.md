# Example Output: pagination-implementation

**Expected Output Shape:**
```typescript
// Cursor-based chosen: 5M rows + real-time inserts = offset would skip/duplicate records

interface PaginatedResponse<T> {
  data: T[];
  nextCursor: string | null;
  hasMore: boolean;
}

function encodeCursor(createdAt: Date, id: string): string {
  return Buffer.from(JSON.stringify({ createdAt: createdAt.toISOString(), id })).toString('base64url');
}

function decodeCursor(cursor: string): { createdAt: string; id: string } {
  return JSON.parse(Buffer.from(cursor, 'base64url').toString());
}

router.get('/events', async (req: Request, res: Response) => {
  const userId = req.user.id;
  const limit = Math.min(parseInt(req.query.limit as string) || 20, 100); // cap at 100
  const cursor = req.query.cursor as string | undefined;

  let whereClause = 'WHERE user_id = $1';
  const params: unknown[] = [userId];

  if (cursor) {
    const { createdAt, id } = decodeCursor(cursor);
    // Keyset pagination: fetch rows "after" the cursor position
    whereClause += ` AND (created_at, id) < ($${params.length + 1}, $${params.length + 2})`;
    params.push(createdAt, id);
  }

  // Fetch limit+1 to determine if there are more pages
  const result = await db.query(
    `SELECT id, title, created_at FROM events ${whereClause}
     ORDER BY created_at DESC, id DESC LIMIT $${params.length + 1}`,
    [...params, limit + 1]
  );

  const hasMore = result.rows.length > limit;
  const data = result.rows.slice(0, limit);
  const nextCursor = hasMore
    ? encodeCursor(data[data.length - 1].created_at, data[data.length - 1].id)
    : null;

  res.json({ data, nextCursor, hasMore });
});
```

Required index: `CREATE INDEX idx_events_user_created ON events (user_id, created_at DESC, id DESC);`

Client usage:
```typescript
let cursor: string | null = null;
do {
  const response = await fetch(`/events?limit=20${cursor ? `&cursor=${cursor}` : ''}`);
  const page = await response.json();
  processEvents(page.data);
  cursor = page.nextCursor;
} while (cursor);
```


**Expected Output Shape:**
```python
from fastapi import APIRouter, Depends, Query
from sqlalchemy.orm import Session
from app.database import get_db
from app.models import Product

router = APIRouter()

class PaginatedResponse(BaseModel):
    data: list[ProductSchema]
    total: int
    page: int
    limit: int
    has_next: bool
    has_prev: bool

@router.get("/products", response_model=PaginatedResponse)
def list_products(
    page: int = Query(default=1, ge=1),
    limit: int = Query(default=20, ge=1, le=100),
    db: Session = Depends(get_db),
):
    offset = (page - 1) * limit

    # For 50k rows, COUNT(*) is acceptable; for millions, consider caching the count
    total = db.query(func.count(Product.id)).scalar()

    products = (
        db.query(Product)
        .order_by(Product.name)
        .offset(offset)
        .limit(limit)
        .all()
    )

    return PaginatedResponse(
        data=products,
        total=total,
        page=page,
        limit=limit,
        has_next=offset + limit < total,
        has_prev=page > 1,
    )
```

Required index: `CREATE INDEX idx_products_name ON products (name);`
