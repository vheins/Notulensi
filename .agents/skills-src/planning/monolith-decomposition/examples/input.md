# Example Input: monolith-decomposition

### Example 1: Rails Monolith → Node.js Microservices — E-commerce
**Input:**
- `{{monolith_description}}`: "Rails monolith with 8 modules: users, products, orders, payments, inventory, notifications, reviews, analytics. 200k LOC. Shared PostgreSQL database. Deployed on Heroku. Pain points: deployments take 45 minutes, payment module changes break unrelated features, analytics queries slow down the main DB."
- `{{tech_stack}}`: "Ruby on Rails monolith → Node.js + PostgreSQL (per service) + Kafka + Kubernetes"
- `{{target_architecture}}`: "6 independent services: User, Product, Order, Payment, Notification, Analytics. Each with its own database. Event-driven communication via Kafka."


### Example 2: Django Monolith → Python Microservices — SaaS Platform
**Input:**
- `{{monolith_description}}`: "Django monolith with 5 apps: accounts, billing, projects, tasks, reports. 80k LOC. MySQL database. Deployed on AWS EC2. Pain points: billing changes require full regression testing of all apps; reports module causes DB timeouts."
- `{{tech_stack}}`: "Django monolith → Python + FastAPI (per service) + PostgreSQL + RabbitMQ + Docker"
- `{{target_architecture}}`: "4 services: Account, Billing, Project/Task, Reports. Event-driven via RabbitMQ."
