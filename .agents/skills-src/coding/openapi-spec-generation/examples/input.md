# Example Input: openapi-spec-generation

### Example 1: Node.js + Express — User Management API
**Input:**
- `{{tech_stack}}`: Node.js + TypeScript + Express
- `{{api_description}}`: "User management API with: POST /auth/register (email, password), POST /auth/login (email, password → JWT), GET /users/me (requires auth), PATCH /users/me (update name/email), DELETE /users/me. Errors: { error: string, code: string }."
- `{{context}}`: "API v1, base URL https://api.example.com/v1, public API, JWT Bearer auth"


### Example 2: Python + FastAPI — Product Catalog API
**Input:**
- `{{tech_stack}}`: Python + FastAPI (auto-generates OpenAPI, but needs customization)
- `{{api_description}}`: "Product catalog: GET /products (paginated, filter by category), GET /products/{id}, POST /products (admin only), PATCH /products/{id} (admin only). Products: { id, name, price, category, inStock }."
- `{{context}}`: "API v2, internal + partner API, API key auth, base URL https://catalog.internal/v2"
