# Example Input: performance-load-test-scripting

## Example 1: Product listing API

| Variable | Value |
|----------|-------|
| `{{api_endpoints}}` | `GET /api/products?page=1&limit=20` — paginated product list with filters |
| `{{tech_stack}}` | k6 + Node.js + Express + PostgreSQL |
| `{{performance_targets}}` | P95 < 300ms, error rate < 0.1%, sustain 500 concurrent users for 10 minutes |
