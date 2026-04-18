# Example Input: api-contract-test-generation

## Example 1: Orders API — POST /orders

| Variable | Value |
|----------|-------|
| `{{api_spec}}` | `POST /api/v1/orders` — body: `{ userId: string, items: [{ productId: string, quantity: number }] }` — returns 201 with created order or 400/404/422 |
| `{{tech_stack}}` | Node.js + Express + Jest + supertest |
| `{{context}}` | Auth via Bearer JWT, errors as `{ error: string, details?: object }` |
