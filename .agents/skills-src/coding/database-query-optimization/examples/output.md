# Example Output: database-query-optimization

### Example 1: PostgreSQL + Node.js (raw SQL)

**Expected Output:**
```
Problem Diagnosis:
- Sequential scan on orders (1.2M rows) because no index on (status, created_at)
- SELECT * fetches all columns including large text fields not needed by caller
- JOIN on user_id has no index (foreign key not automatically indexed in PostgreSQL)

Index Recommendations:
1. CREATE INDEX idx_orders_status_created ON orders (status, created_at DESC)
   WHERE status = 'pending';
   -- Partial index: only indexes pending orders, dramatically smaller index size
   -- Covers both the WHERE filter and ORDER BY in one index scan

2. CREATE INDEX idx_orders_user_id ON orders (user_id);
   -- Enables index nested loop join instead of hash join for the user lookup

Optimized Query:
SELECT o.id, o.user_id, o.status, o.total, o.created_at,
       u.name, u.email
FROM orders o
JOIN users u ON o.user_id = u.id
WHERE o.status = 'pending'
  AND o.created_at > NOW() - INTERVAL '7 days'
ORDER BY o.created_at DESC;

Changes: Replaced SELECT * with explicit columns to reduce data transfer.

Performance Impact:
- Before: Seq Scan, ~1.2M rows examined, ~800ms
- After: Index Scan on idx_orders_status_created, ~500 rows examined, ~5ms
- Expected improvement: ~160x latency reduction

Trade-offs:
- Two new indexes add ~50ms overhead to INSERT/UPDATE on orders table
- Partial index only helps queries filtering on status='pending'; add separate index for other statuses if needed
```

---

### Example 2: MySQL + Java + Hibernate

**Expected Output:**
```
Problem Diagnosis:
- HQL join on p.category.name triggers a JOIN + filter on category.name with no index
- price filter has no index — full table scan on product
- Hibernate may generate N+1 if category is lazily loaded elsewhere

Index Recommendations:
1. CREATE INDEX idx_category_name ON category (name);
   -- Converts category name filter from full scan to index lookup

2. CREATE INDEX idx_product_category_price ON product (category_id, price);
   -- Composite index covers both the join condition and price filter

Optimized HQL:
FROM Product p JOIN FETCH p.category c
WHERE c.name = :catName AND p.price < :maxPrice

Changes: Added JOIN FETCH to prevent lazy-load N+1 on category access.

Performance Impact:
- Before: Full scan on product + full scan on category, O(n*m) rows
- After: Index lookup on category.name + index range scan on product, O(log n + k) rows
- Expected improvement: 50–200x depending on data volume

Trade-offs:
- Composite index on (category_id, price) increases INSERT overhead on product table
- JOIN FETCH always loads category — ensure this is desired behavior
```
