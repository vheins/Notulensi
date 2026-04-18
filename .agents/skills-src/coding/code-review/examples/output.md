# Example Output: code-review

### Example 1: TypeScript + Express + PostgreSQL

**Expected Output:**
```
Finding #1
Severity: CRITICAL
Category: Security
Location: db.query() call
Problem: SQL injection vulnerability. `req.query.search` is interpolated directly into the SQL string.
  An attacker can pass `'; DROP TABLE users; --` to destroy data or `' OR '1'='1` to dump all records.
Fix: Use parameterized query:
  db.query('SELECT * FROM users WHERE name ILIKE $1', [`%${req.query.search}%`])

Finding #2
Severity: CRITICAL
Category: Security
Location: Authorization check (line 2)
Problem: Authorization relies on a client-supplied header `x-role`. Any client can set this header to "admin".
  There is no server-side session or JWT verification.
Fix: Verify role from a signed JWT or server-side session, not from a request header.

Finding #3
Severity: HIGH
Category: Error Handling
Location: .catch() handler
Problem: Full error object (including stack trace and DB internals) is returned to the client.
  This leaks schema information and aids attackers.
Fix: Log error internally, return generic message: res.status(500).json({ error: 'Internal server error' })

Summary:
- CRITICAL: 2 | HIGH: 1 | MEDIUM: 0 | LOW: 0
- Assessment: REQUEST CHANGES
- Top 3: Fix SQL injection, fix auth bypass, sanitize error responses
```

---

### Example 2: Python + Django

**Expected Output:**
```
Finding #1
Severity: HIGH
Category: Performance
Location: list() method, for loop
Problem: N+1 query. For each product, `product.category.name` triggers a separate SQL query.
  With 1000 products, this executes 1001 queries instead of 1.
Fix: Use select_related: Product.objects.select_related('category').all()

Finding #2
Severity: MEDIUM
Category: Maintainability
Location: list() method
Problem: Overrides list() but duplicates the queryset defined in the class attribute.
  The class-level queryset is ignored, creating a maintenance inconsistency.
Fix: Remove the class-level queryset or use get_queryset() to centralize the query logic.

Finding #3
Severity: LOW
Category: Style
Location: ProductViewSet class
Problem: No pagination configured. ModelViewSet will return all records, which is dangerous at scale.
Fix: Add pagination_class or configure DEFAULT_PAGINATION_CLASS in settings.

Summary:
- HIGH: 1 | MEDIUM: 1 | LOW: 1
- Assessment: REQUEST CHANGES
- Top 3: Fix N+1 query, remove duplicate queryset, add pagination
```
