# Example Input: dependency-mapping

### Example 1: Node.js Microservices — E-commerce Platform
**Input:**
- `{{module_list}}`: "OrderService, PaymentService, InventoryService, NotificationService, UserService"
- `{{tech_stack}}`: "Node.js microservices, REST HTTP calls, shared PostgreSQL database"
- `{{context}}`: "OrderService calls PaymentService synchronously to charge. OrderService calls InventoryService to reserve stock. PaymentService calls NotificationService to send receipt. InventoryService calls OrderService to check order status. All services share one PostgreSQL database."


### Example 2: Python Monolith — Django Application
**Input:**
- `{{module_list}}`: "accounts, billing, projects, tasks, reports, notifications"
- `{{tech_stack}}`: "Python + Django monolith, direct function imports between modules"
- `{{context}}`: "accounts module imported by all others for user lookup. billing imports projects to calculate usage. reports imports tasks, projects, and billing. notifications imports accounts and tasks. tasks imports accounts and projects."
