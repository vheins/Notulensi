# Example Input: brainstorm-feature

## Example 1: Multi-Currency Payment

| Variable | Value |
|----------|-------|
| `{{feature_name}}` | `Multi-Currency Payment` |
| `{{business_context}}` | `Platform serves users in 15 countries. Currently only supports USD. Users abandon checkout when they see foreign currency prices.` |
| `{{tech_stack}}` | `Node.js + PostgreSQL + Stripe` |
| `{{constraints}}` | `Must not break existing USD payment flow. Exchange rates updated daily.` |

---

## Example 2: Approval Workflow

| Variable | Value |
|----------|-------|
| `{{feature_name}}` | `Multi-Level Approval Workflow` |
| `{{business_context}}` | `Purchase orders above $10k require manager + finance approval before processing. Currently done via email with no audit trail.` |
| `{{tech_stack}}` | `Python + Django + Celery` |
| `{{constraints}}` | `Must support parallel approvals. Approvers can delegate.` |
