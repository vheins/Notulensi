# Example Output: api-contract-design

**Expected Output Shape:**
```
1. Endpoint Definitions
POST   /api/v1/auth/register     — Register new user
POST   /api/v1/auth/login        — Authenticate and receive JWT
GET    /api/v1/users/me          — Get authenticated user profile
PATCH  /api/v1/users/me          — Update authenticated user profile
DELETE /api/v1/users/me          — Delete authenticated user account
GET    /api/v1/users             — List all users (admin only); query: ?page=1&limit=20

2. Request/Response Examples
POST /api/v1/auth/register
Request:  { "email": "user@example.com", "password": "SecurePass123!" }
Response 201: { "id": "uuid", "email": "user@example.com", "createdAt": "ISO8601" }
Response 409: { "error": "EMAIL_ALREADY_EXISTS", "message": "An account with this email already exists." }

3. Error Codes
| Error Code | HTTP Status | Message | When It Occurs |
|------------|-------------|---------|----------------|
| EMAIL_ALREADY_EXISTS | 409 | An account with this email already exists. | POST /register with duplicate email |
| INVALID_CREDENTIALS | 401 | Email or password is incorrect. | POST /login with wrong credentials |
| TOKEN_EXPIRED | 401 | Authentication token has expired. | Any authenticated endpoint with expired JWT |
| FORBIDDEN | 403 | You do not have permission to perform this action. | Non-admin accessing /users list |
| USER_NOT_FOUND | 404 | User not found. | GET/PATCH/DELETE with non-existent user ID |

4. Authentication
- Method: Bearer JWT in Authorization header
- Public: POST /register, POST /login
- Authenticated: GET /users/me, PATCH /users/me, DELETE /users/me
- Admin only: GET /users (requires role: "admin" in JWT claims)

5. Rate Limiting
- POST /register: 5 requests/hour per IP
- POST /login: 10 requests/minute per IP
- All other endpoints: 100 requests/minute per user
- Headers: X-RateLimit-Limit, X-RateLimit-Remaining, X-RateLimit-Reset
- Exceeded: HTTP 429 + Retry-After: [seconds]
```


**Expected Output Shape:**
```
1. GraphQL Schema
type Product {
  id: ID!
  name: String!
  description: String
  price: Float!
  stockQuantity: Int!
  category: String!
  createdAt: DateTime!
  updatedAt: DateTime!
}

type Query {
  product(id: ID!): Product
  products(category: String, minPrice: Float, maxPrice: Float, page: Int, limit: Int): ProductConnection!
}

type Mutation {
  createProduct(input: CreateProductInput!): Product!
  updateProduct(id: ID!, input: UpdateProductInput!): Product!
  deleteProduct(id: ID!): Boolean!
}

2. Request/Response Examples
Query: product(id: "prod_123")
Response: { "data": { "product": { "id": "prod_123", "name": "Widget Pro", "price": 29.99, ... } } }
Error: { "errors": [{ "message": "Product not found", "extensions": { "code": "PRODUCT_NOT_FOUND" } }] }

3. Error Codes
| Error Code | HTTP Status | Message | When It Occurs |
|------------|-------------|---------|----------------|
| PRODUCT_NOT_FOUND | 200 (GraphQL) | Product not found. | Query with non-existent product ID |
| UNAUTHORIZED | 401 | Authentication required. | Mutation without valid token |
| VALIDATION_ERROR | 200 (GraphQL) | Input validation failed. | Invalid price (negative) or missing required field |
| DUPLICATE_SKU | 200 (GraphQL) | A product with this SKU already exists. | createProduct with duplicate SKU |

4. Authentication
- Method: Bearer JWT in Authorization header
- Public: product query, products query
- Authenticated: createProduct, updateProduct, deleteProduct mutations

5. Rate Limiting
- Queries: 200 requests/minute per user
- Mutations: 30 requests/minute per user
- Exceeded: HTTP 429 with Retry-After header
```
