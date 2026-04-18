# Example Input: database-schema-planning

### Example 1: PostgreSQL + Prisma — E-commerce Platform
**Input:**
- `{{domain_description}}`: "E-commerce platform with customers, products, orders, order items, and product reviews. Customers can have multiple addresses."
- `{{tech_stack}}`: "PostgreSQL + Prisma + Node.js"
- `{{scale_requirements}}`: "500k products, 2M orders/year, heavy read on product listings and order history, write-heavy on order creation"


### Example 2: MySQL + Hibernate — SaaS Multi-tenant Platform
**Input:**
- `{{domain_description}}`: "Multi-tenant SaaS with organizations, users, projects, and tasks. Users belong to organizations. Tasks have assignees and due dates."
- `{{tech_stack}}`: "MySQL 8 + Hibernate + Spring Boot"
- `{{scale_requirements}}`: "10k organizations, 100k users, 5M tasks, heavy read on task lists filtered by assignee and status"
