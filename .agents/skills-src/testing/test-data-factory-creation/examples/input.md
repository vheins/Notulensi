# Example Input: test-data-factory-creation

## Example 1: User model factory

| Variable | Value |
|----------|-------|
| `{{data_model}}` | `User { id: uuid, name: string, email: string, role: 'user'\|'admin', status: 'active'\|'inactive', createdAt: Date }` |
| `{{tech_stack}}` | TypeScript + Fishery + Faker.js + Jest + Prisma |
| `{{edge_cases}}` | admin user, inactive user, user with very long name |
