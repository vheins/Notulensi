# Example Input: api-implementation

## Example 1: TypeScript + Express + Zod + Prisma

| Variable | Value |
|----------|-------|
| `{{tech_stack}}` | TypeScript + Express + Zod + Prisma + Jest |
| `{{api_spec}}` | "POST /orders — Create a new order. Body: `{ userId: string, items: [{ productId: string, quantity: number }] }`. Rules: userId must exist, each productId must exist and have sufficient stock, quantity must be >= 1. Returns created order with total price." |
| `{{context}}` | "Prisma models: User, Product (with stock field), Order, OrderItem. Errors returned as `{ error: string, details?: object }`. Auth middleware sets `req.user`." |

---

## Example 2: Go + Gin + GORM

| Variable | Value |
|----------|-------|
| `{{tech_stack}}` | Go + Gin + GORM + testify |
| `{{api_spec}}` | "GET /articles?tag=string&page=int — List published articles filtered by tag, paginated (20 per page). Returns `{ articles: [], total: int, page: int }`." |
| `{{context}}` | "GORM model: Article(ID, Title, Body, Tags []string, Status string, CreatedAt). Gin context used for responses. Errors as `{ error: string }`." |
