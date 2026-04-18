# Example Input: domain-modeling

### Example 1: TypeScript + Node.js — Order Management Context
**Input:**
- `{{domain_description}}`: "E-commerce platform. Customers place orders containing products. Orders go through states: pending, confirmed, shipped, delivered, cancelled. Payment must be confirmed before an order is shipped. Orders can be partially fulfilled."
- `{{tech_stack}}`: "TypeScript + Node.js + PostgreSQL"
- `{{bounded_context}}`: "Order Management"


### Example 2: Java + Spring Boot — Inventory Context
**Input:**
- `{{domain_description}}`: "Warehouse inventory management. Products are stored in bins. Stock levels are tracked. Low-stock alerts are triggered when quantity falls below a threshold. Stock can be reserved for pending orders and released if orders are cancelled."
- `{{tech_stack}}`: "Java + Spring Boot + PostgreSQL + Hibernate"
- `{{bounded_context}}`: "Inventory"
