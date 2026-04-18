# Example Input: rest-to-graphql-migration

### Example 1: Node.js + Express → Apollo Server
**Input:**
- `{{tech_stack}}`: Node.js + TypeScript + Express → Apollo Server 4 (adding GraphQL alongside REST)
- `{{rest_api_spec}}`:
```
GET /users/:id → { id, name, email, createdAt }
GET /users/:id/posts → [{ id, title, publishedAt }]
POST /posts → body: { title, body, userId } → { id, title, body, userId, createdAt }
PUT /posts/:id → body: { title?, body? } → updated post
DELETE /posts/:id → 204
GET /posts?userId=&page=&limit= → { posts: [], total, page }
```
- `{{migration_scope}}`: "Strangler fig — add GraphQL endpoint, keep REST active for 6 months"


### Example 2: Python + Flask → Strawberry
**Input:**
- `{{tech_stack}}`: Python + Flask → Strawberry + FastAPI
- `{{rest_api_spec}}`:
```
GET /products → [{ id, name, price, categoryId }]
GET /products/:id → { id, name, price, category: { id, name } }
POST /products → body: { name, price, categoryId }
GET /categories → [{ id, name }]
```
- `{{migration_scope}}`: "Full migration — replace REST with GraphQL over 3 months"
