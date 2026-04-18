# Example Output: database-schema-planning

**Expected Output Shape:**
```
1. Entity-Relationship Description
- Customer has zero or more Orders (one-to-many, FK enforced)
- Customer has zero or more Addresses (one-to-many, FK enforced)
- Order has one or more OrderItems (one-to-many, FK enforced)
- OrderItem references one Product (many-to-one, FK enforced)
- Product has zero or more Reviews (one-to-many, FK enforced)
- Review belongs to one Customer (many-to-one, FK enforced)

2. Table Definitions
Table: customers
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | UUID | PK, DEFAULT gen_random_uuid() | Primary key |
| email | VARCHAR(255) | NOT NULL, UNIQUE | Login email |
| created_at | TIMESTAMPTZ | NOT NULL, DEFAULT NOW() | Account creation time |

Table: orders
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | UUID | PK | Primary key |
| customer_id | UUID | NOT NULL, FK → customers.id | Order owner |
| status | VARCHAR(50) | NOT NULL, DEFAULT 'pending' | Order status |
| total_amount | NUMERIC(10,2) | NOT NULL | Order total |
| created_at | TIMESTAMPTZ | NOT NULL, DEFAULT NOW() | Order creation time |

3. Index Recommendations
- idx_orders_customer_id: orders(customer_id) — supports "get orders by customer" query; high selectivity
- idx_products_category: products(category_id, price) — supports filtered product listing; medium selectivity
- idx_reviews_product_id: reviews(product_id) — supports "get reviews by product"; high selectivity

4. Relationship Constraints
- fk_orders_customer: orders.customer_id → customers.id, ON DELETE RESTRICT (preserve order history)
- fk_order_items_order: order_items.order_id → orders.id, ON DELETE CASCADE (items deleted with order)
- fk_reviews_customer: reviews.customer_id → customers.id, ON DELETE SET NULL (preserve reviews if customer deleted)

5. Migration Notes
Migration order: customers → addresses → products → orders → order_items → reviews
Seed data: product_categories lookup table must be seeded before products.
Denormalization note: orders.total_amount is denormalized (could be computed from order_items) — justified by read performance on order history queries.
```


**Expected Output Shape:**
```
1. Entity-Relationship Description
- Organization has one or more Users (one-to-many, FK enforced)
- Organization has zero or more Projects (one-to-many, FK enforced)
- Project has zero or more Tasks (one-to-many, FK enforced)
- Task has one assignee User (many-to-one, FK enforced, nullable)
- User belongs to one Organization (many-to-one, FK enforced)

2. Table Definitions
Table: organizations
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | BIGINT | PK, AUTO_INCREMENT | Primary key |
| name | VARCHAR(255) | NOT NULL | Organization name |
| slug | VARCHAR(100) | NOT NULL, UNIQUE | URL-safe identifier |
| created_at | DATETIME | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Creation time |

Table: tasks
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | BIGINT | PK, AUTO_INCREMENT | Primary key |
| project_id | BIGINT | NOT NULL, FK → projects.id | Parent project |
| assignee_id | BIGINT | NULL, FK → users.id | Assigned user |
| status | ENUM('todo','in_progress','done') | NOT NULL, DEFAULT 'todo' | Task status |
| due_date | DATE | NULL | Optional due date |

3. Index Recommendations
- idx_tasks_assignee_status: tasks(assignee_id, status) — supports "my tasks by status" query; high selectivity
- idx_tasks_project_id: tasks(project_id) — supports "tasks in project" query; high selectivity
- idx_users_org_id: users(organization_id) — supports "users in org" query; medium selectivity

4. Relationship Constraints
- fk_tasks_project: tasks.project_id → projects.id, ON DELETE CASCADE
- fk_tasks_assignee: tasks.assignee_id → users.id, ON DELETE SET NULL (preserve tasks if user deleted)
- fk_users_org: users.organization_id → organizations.id, ON DELETE RESTRICT

5. Migration Notes
Migration order: organizations → users → projects → tasks
Multi-tenancy: Add organization_id to all tenant-scoped tables; add composite index (organization_id, id) for tenant isolation queries.
```
