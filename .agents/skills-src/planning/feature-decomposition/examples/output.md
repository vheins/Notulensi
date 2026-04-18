# Example Output: feature-decomposition

**Expected Output Shape:**
```
| Task # | Task Name | Description | Effort | Dependencies | Acceptance Criteria |
|--------|-----------|-------------|--------|--------------|---------------------|
| T1 | Database schema for users | Create User table with email, password_hash, provider fields | S | None | Migration runs; User model has all required fields |
| T2 | NextAuth.js configuration | Configure NextAuth with credentials + Google provider | M | T1 | Auth session created on login; JWT contains user ID |
| T3 | Registration API endpoint | POST /api/auth/register with validation and password hashing | M | T1 | Returns 201 on success; 409 on duplicate email |
| T4 | Login page UI | Email/password form with error states and loading indicator | M | T2 | Form submits; errors display; redirects on success |
| T5 | Password reset flow | Forgot password email + reset token endpoint | L | T1, T3 | Token expires in 1 hour; password updated on valid token |
| T6 | Google OAuth callback | Handle OAuth callback, create/link user account | M | T2 | New users created; existing users linked by email |

Implementation Order: T1 → T2 → T3 → T4 → T5, T6 (parallel after T2)
Parallel Work: T4 and T5 can proceed simultaneously after T2 is complete.
Risk Flags: T5 requires email service setup (external dependency — confirm SMTP/SendGrid config early).
```


**Expected Output Shape:**
```
| Task # | Task Name | Description | Effort | Dependencies | Acceptance Criteria |
|--------|-----------|-------------|--------|--------------|---------------------|
| T1 | Product SQLAlchemy model | Define Product model with stock_quantity, alert_threshold fields | S | None | Model maps to DB; migrations pass |
| T2 | Product CRUD endpoints | GET/POST/PUT/DELETE /products with Pydantic validation | M | T1 | All endpoints return correct status codes and schemas |
| T3 | Stock update endpoint | PATCH /products/{id}/stock with delta support | S | T1 | Stock decrements/increments correctly; rejects negative stock |
| T4 | Low-stock detection logic | Service function to query products below threshold | S | T1 | Returns correct list; handles empty result |
| T5 | Celery alert task | Async task to send email when stock alert triggered | M | T4 | Task queued on stock update; email sent with product details |
| T6 | Alert scheduling | Periodic Celery beat task to check all products daily | M | T4, T5 | Beat schedule configured; task runs on schedule |

Implementation Order: T1 → T2 → T3 → T4 → T5 → T6
Parallel Work: T2 and T4 can proceed simultaneously after T1.
Risk Flags: T5 requires email provider config; T6 requires Celery Beat infrastructure setup.
```
