# Example Output: openapi-spec-generation

**Expected Output Shape:**
```yaml
openapi: "3.1.0"
info:
  title: User Management API
  version: "1.0.0"
  description: API for user registration, authentication, and profile management
  contact:
    email: api@example.com

servers:
  - url: https://api.example.com/v1
    description: Production
  - url: https://staging-api.example.com/v1
    description: Staging
  - url: http://localhost:3000/v1
    description: Development

security:
  - bearerAuth: []

components:
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer
      bearerFormat: JWT

  schemas:
    User:
      type: object
      properties:
        id: { type: string, format: uuid }
        email: { type: string, format: email }
        name: { type: string }
        createdAt: { type: string, format: date-time }
      required: [id, email, name, createdAt]

    ErrorResponse:
      type: object
      properties:
        error: { type: string }
        code: { type: string }
      required: [error, code]

    RegisterRequest:
      type: object
      properties:
        email: { type: string, format: email }
        password: { type: string, minLength: 8 }
      required: [email, password]

paths:
  /auth/register:
    post:
      tags: [Authentication]
      summary: Register a new user
      security: []  # No auth required
      requestBody:
        required: true
        content:
          application/json:
            schema: { $ref: '#/components/schemas/RegisterRequest' }
            example:
              email: user@example.com
              password: securepassword123
      responses:
        '201':
          description: User created successfully
          content:
            application/json:
              schema: { $ref: '#/components/schemas/User' }
        '409':
          description: Email already registered
          content:
            application/json:
              schema: { $ref: '#/components/schemas/ErrorResponse' }
              example: { error: "Email already registered", code: "DUPLICATE_EMAIL" }
        '400':
          description: Validation error
          content:
            application/json:
              schema: { $ref: '#/components/schemas/ErrorResponse' }

  /users/me:
    get:
      tags: [Users]
      summary: Get current user profile
      responses:
        '200':
          description: Current user profile
          content:
            application/json:
              schema: { $ref: '#/components/schemas/User' }
        '401':
          description: Unauthorized
          content:
            application/json:
              schema: { $ref: '#/components/schemas/ErrorResponse' }
```


**Expected Output Shape:**
```yaml
openapi: "3.1.0"
info:
  title: Product Catalog API
  version: "2.0.0"
  description: Internal product catalog service for inventory and pricing

servers:
  - url: https://catalog.internal/v2

components:
  securitySchemes:
    apiKey:
      type: apiKey
      in: header
      name: X-API-Key

  schemas:
    Product:
      type: object
      properties:
        id: { type: string, format: uuid }
        name: { type: string }
        price: { type: number, format: float, minimum: 0 }
        category: { type: string }
        inStock: { type: boolean }
      required: [id, name, price, category, inStock]

    PaginatedProducts:
      type: object
      properties:
        data:
          type: array
          items: { $ref: '#/components/schemas/Product' }
        total: { type: integer }
        page: { type: integer }
        limit: { type: integer }

paths:
  /products:
    get:
      tags: [Products]
      summary: List products with optional filtering
      parameters:
        - name: category
          in: query
          schema: { type: string }
          description: Filter by category name
        - name: page
          in: query
          schema: { type: integer, default: 1, minimum: 1 }
        - name: limit
          in: query
          schema: { type: integer, default: 20, minimum: 1, maximum: 100 }
      responses:
        '200':
          description: Paginated product list
          content:
            application/json:
              schema: { $ref: '#/components/schemas/PaginatedProducts' }
    post:
      tags: [Products]
      summary: Create a new product (admin only)
      security:
        - apiKey: []
      requestBody:
        required: true
        content:
          application/json:
            schema:
              type: object
              properties:
                name: { type: string }
                price: { type: number, minimum: 0 }
                category: { type: string }
              required: [name, price, category]
      responses:
        '201':
          description: Product created
          content:
            application/json:
              schema: { $ref: '#/components/schemas/Product' }
        '403':
          description: Insufficient permissions
```
