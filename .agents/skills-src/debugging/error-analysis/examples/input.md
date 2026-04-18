# Example Input: error-analysis

### Example 1: Node.js + Express + PostgreSQL
**Input:**
- `{{tech_stack}}`: Node.js + Express + PostgreSQL
- `{{error_message}}`: `TypeError: Cannot read properties of undefined (reading 'id')`
- `{{stack_trace}}`: `at getUserById (/app/services/userService.js:42:18)\n    at async /app/routes/users.js:15:20`
- `{{context}}`: Route handler calls `userService.getUserById(req.params.id)` which queries the DB and returns the user object


### Example 2: Python + FastAPI + SQLAlchemy
**Input:**
- `{{tech_stack}}`: Python + FastAPI + SQLAlchemy
- `{{error_message}}`: `sqlalchemy.exc.IntegrityError: (psycopg2.errors.UniqueViolation) duplicate key value violates unique constraint "users_email_key"`
- `{{stack_trace}}`: `File "/app/crud/user.py", line 28, in create_user\n    db.commit()`
- `{{context}}`: POST /users endpoint creates a new user record; no uniqueness check before insert
