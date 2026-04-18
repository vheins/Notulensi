# Example Input: database-query-optimization

### Example 1: PostgreSQL + Node.js (raw SQL)

**Input:**
- `{{tech_stack}}`: PostgreSQL 15 + Node.js (pg library)
- `{{slow_query}}`:
```sql
SELECT * FROM orders o
JOIN users u ON o.user_id = u.id
WHERE o.status = 'pending'
  AND o.created_at > NOW() - INTERVAL '7 days'
ORDER BY o.created_at DESC;
```
- `{{schema}}`:
```sql
CREATE TABLE orders (
  id UUID PRIMARY KEY,
  user_id UUID NOT NULL,
  status VARCHAR(20) NOT NULL,
  total DECIMAL(10,2),
  created_at TIMESTAMPTZ DEFAULT NOW()
);
-- Existing indexes: PRIMARY KEY on id only

CREATE TABLE users (
  id UUID PRIMARY KEY,
  email VARCHAR(255) UNIQUE,
  name VARCHAR(255)
);
```
- `{{explain_output}}`: "Seq Scan on orders (cost=0.00..45230.00 rows=1200000)"

---

### Example 2: MySQL + Java + Hibernate

**Input:**
- `{{tech_stack}}`: MySQL 8 + Java + Hibernate (HQL)
- `{{slow_query}}`:
```java
List<Product> products = session.createQuery(
  "FROM Product p WHERE p.category.name = :catName AND p.price < :maxPrice",
  Product.class
).setParameter("catName", "Electronics").setParameter("maxPrice", 500.0).getResultList();
```
- `{{schema}}`:
```sql
CREATE TABLE product (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255),
  price DECIMAL(10,2),
  category_id BIGINT,
  FOREIGN KEY (category_id) REFERENCES category(id)
);
CREATE TABLE category (id BIGINT PRIMARY KEY, name VARCHAR(100));
-- No indexes beyond PKs and FK
```
- `{{explain_output}}`: ""
