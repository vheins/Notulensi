# Example Input: architecture-documentation

### Example 1: Node.js Microservices — E-Commerce Platform
**Input:**
- `{{system_name}}`: "ShopStream"
- `{{system_description}}`: "ShopStream is a B2C e-commerce platform that allows customers to browse products, place orders, and track shipments. It serves ~50,000 daily active users and integrates with third-party payment processors and logistics providers. The system is responsible for the full order lifecycle from cart to delivery confirmation."
- `{{tech_stack}}`: "Node.js (Express), React, PostgreSQL, Redis, RabbitMQ, Stripe API, Shippo API, AWS S3, NGINX, Docker"
- `{{deployment_target}}`: "AWS ECS (Fargate) with RDS and ElastiCache"


### Example 2: Go + gRPC — Microservices Platform
**Input:**
- `{{tech_stack}}`: Go + gRPC + Kubernetes + PostgreSQL + Redis + Kafka
- `{{project_name}}`: "PaymentService"
- `{{architecture_description}}`: "Payment processing microservice handling charge, refund, and webhook events. Communicates via gRPC with OrderService and NotificationService."
