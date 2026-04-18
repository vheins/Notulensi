# Example Input: design-pattern-application

### Example 1: TypeScript + Node.js — Payment Processing
**Input:**
- `{{tech_stack}}`: TypeScript + Node.js
- `{{problem_description}}`: "We need to support multiple payment providers (Stripe, PayPal, Braintree). Each has a different SDK and API. We want to add new providers without modifying existing code. Currently all payment logic is in one giant PaymentService class with if/else chains."
- `{{context}}`: "Express REST API. PaymentService is called from OrderController. Each provider needs: charge(amount, currency, token), refund(transactionId), getStatus(transactionId)."


### Example 2: Python + FastAPI — Notification System
**Input:**
- `{{tech_stack}}`: Python + FastAPI
- `{{problem_description}}`: "When an order is placed, we need to send an email, update inventory, and notify the warehouse. Adding more actions keeps growing the order creation function. We want to decouple these side effects from the core order logic."
- `{{context}}`: "FastAPI app with SQLAlchemy. OrderService.create_order() currently calls EmailService, InventoryService, WarehouseService directly. Team wants to add SMS and analytics tracking soon."
