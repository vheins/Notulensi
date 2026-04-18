# Example Input: database-migration-test

## Example 1: Add status column to orders table

| Variable | Value |
|----------|-------|
| `{{migration_code}}` | Add `status` column (enum: pending/paid/cancelled, default: pending) to `orders` table. Backfill existing rows: set status=paid where payment_id IS NOT NULL, else pending. |
| `{{tech_stack}}` | Node.js + Prisma + PostgreSQL |
| `{{context}}` | orders table has 500k rows in production. Migration must be zero-downtime. |
