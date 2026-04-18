# Example Output: database-query-slow-analysis

**Expected Output Shape:**
```
1. Query Plan Interpretation
Seq Scan on orders: scanning all 1,000,000 rows to find 1,200 matching rows.
Filter removes 998,800 rows — 99.9% of the table is scanned unnecessarily.
Actual time: 3,420ms — dominated by the sequential scan.

2. Problem Identification
- Missing composite index on (status, created_at) — forces full table scan
- SELECT * fetches all columns including large text fields — unnecessary data transfer
- No index on user_id for the JOIN — may cause nested loop with seq scan on users

3. Index Recommendations
CREATE INDEX idx_orders_status_created ON orders(status, created_at DESC);
-- Reduces scan from 1M rows to ~1,200 rows matching status='pending' AND created_at > '2025-01-01'

CREATE INDEX idx_orders_user_id ON orders(user_id);
-- Accelerates the JOIN with users table

4. Query Rewrite
SELECT o.id, o.status, o.created_at, o.total, u.email, u.name
FROM orders o
JOIN users u ON o.user_id = u.id
WHERE o.status = 'pending'
  AND o.created_at > '2025-01-01'
ORDER BY o.created_at DESC
LIMIT 20;
-- Replace SELECT * with specific columns to reduce data transfer

5. Statistics and Maintenance
ANALYZE orders;  -- update statistics after adding index
Expected improvement: 3,420ms → ~5ms (680x improvement)
```


**Expected Output Shape:**
```
1. Query Plan Interpretation
type: ALL = full table scan on 500,000 rows.
Using filesort = in-memory sort of all results — expensive for large result sets.
Existing index on products(name) is NOT used because LOWER() function wraps the column.

2. Problem Identification
- LOWER(p.name) prevents index use — function on indexed column disables the index
- Full table scan on 500,000 rows for a text search
- Using filesort on potentially large result set

3. Index Recommendations
-- Option A: Functional index (MySQL 8+)
CREATE INDEX idx_products_name_lower ON products((LOWER(name)));

-- Option B: Use FULLTEXT index for text search
ALTER TABLE products ADD FULLTEXT INDEX ft_products_name (name);
-- Then use: WHERE MATCH(p.name) AGAINST ('laptop' IN BOOLEAN MODE)

4. Query Rewrite
-- With functional index:
SELECT p.id, p.name, p.price, p.stock, c.name as category_name
FROM products p
LEFT JOIN categories c ON p.category_id = c.id
WHERE LOWER(p.name) LIKE '%laptop%'  -- now uses functional index
ORDER BY p.price ASC;

-- With FULLTEXT (better for search):
WHERE MATCH(p.name) AGAINST ('laptop' IN BOOLEAN MODE)

5. Statistics and Maintenance
ANALYZE TABLE products;  -- update statistics after adding index
Consider: Elasticsearch or MySQL FULLTEXT for production search workloads
```
