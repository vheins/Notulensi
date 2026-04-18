# Example Input: database-query-slow-analysis

### Example 1: PostgreSQL 15 + Prisma
**Input:**
- `{{tech_stack}}`: PostgreSQL 15 + Prisma + Node.js
- `{{slow_query}}`: `SELECT * FROM orders o JOIN users u ON o.user_id = u.id WHERE o.status = 'pending' AND o.created_at > '2025-01-01' ORDER BY o.created_at DESC LIMIT 20;`
- `{{explain_output}}`: `Seq Scan on orders (cost=0.00..45230.00 rows=1200 width=256) (actual time=0.05..3420.00 rows=1200 loops=1)\n  Filter: (status = 'pending' AND created_at > '2025-01-01')\n  Rows Removed by Filter: 998800`
- `{{schema}}`: `orders(id, user_id, status, created_at, total); users(id, email, name); no indexes on orders except PK`


### Example 2: MySQL 8 + Hibernate + Spring Boot
**Input:**
- `{{tech_stack}}`: MySQL 8 + Hibernate + Spring Boot
- `{{slow_query}}`: `SELECT p.*, c.name as category_name FROM products p LEFT JOIN categories c ON p.category_id = c.id WHERE LOWER(p.name) LIKE '%laptop%' ORDER BY p.price ASC;`
- `{{explain_output}}`: `type: ALL, rows: 500000, Extra: Using filesort; no index used`
- `{{schema}}`: `products(id, name VARCHAR(255), price DECIMAL, category_id, stock); categories(id, name); index on products(name)`
