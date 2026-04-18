# Example Input: code-generation

### Example 1: TypeScript + Express + PostgreSQL

**Input:**
- `{{tech_stack}}`: TypeScript + Express + PostgreSQL (via pg library)
- `{{feature_description}}`: "Create a POST /users endpoint that registers a new user. It should validate the email format, hash the password using bcrypt, store the user in the database, and return the created user object without the password field."
- `{{context}}`: "Existing User model: `{ id: uuid, email: string, password_hash: string, created_at: timestamp }`. Express router pattern used throughout the codebase. Errors are returned as `{ error: string, code: string }`."

---

### Example 2: Python + FastAPI + SQLAlchemy

**Input:**
- `{{tech_stack}}`: Python + FastAPI + SQLAlchemy + Alembic
- `{{feature_description}}`: "Create a GET /products/{product_id} endpoint that fetches a product by ID. If the product is not found, return a 404. Include the product's category name from a joined categories table."
- `{{context}}`: "SQLAlchemy models: `Product(id, name, price, category_id)`, `Category(id, name)`. FastAPI dependency injection used for DB sessions. HTTPException used for error responses."
