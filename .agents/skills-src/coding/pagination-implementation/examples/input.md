# Example Input: pagination-implementation

### Example 1: TypeScript + Express + PostgreSQL — Cursor-Based
**Input:**
- `{{tech_stack}}`: TypeScript + Express + PostgreSQL (pg library)
- `{{api_or_ui}}`: "REST API endpoint GET /events"
- `{{data_model}}`: "events table: id (uuid), title, created_at (timestamptz), user_id. ~5M rows. Sorted by created_at DESC. Filtered by user_id. Real-time inserts frequent."


### Example 2: Python + FastAPI + SQLAlchemy — Offset Pagination
**Input:**
- `{{tech_stack}}`: Python + FastAPI + SQLAlchemy 2 + PostgreSQL
- `{{api_or_ui}}`: "REST API endpoint GET /products — admin dashboard, supports random page access"
- `{{data_model}}`: "products table: id, name, price, category_id, created_at. ~50k rows. Sorted by name. Admin use case — random page access needed."
