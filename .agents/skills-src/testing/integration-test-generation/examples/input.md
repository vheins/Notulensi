# Example Input: integration-test-generation

## Example 1: Order creation API endpoint

| Variable | Value |
|----------|-------|
| `{{tech_stack}}` | Node.js + Express + Prisma + PostgreSQL + Jest + supertest |
| `{{integration_scope}}` | `POST /api/orders` — full flow from HTTP request through service layer to DB, with real PostgreSQL test DB |
| `{{code_context}}` | OrderController → OrderService → Prisma. External payment gateway is mocked. Auth via JWT middleware. |
