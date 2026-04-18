# Example Output: test-case-design

## Example 1: User registration feature

**Test Case Matrix**

| ID | Level | Type | Input | Expected | Priority |
|----|-------|------|-------|----------|----------|
| TC-001 | Unit | Positive | Valid name, email, password | User created, hash stored, email queued | High |
| TC-002 | Unit | Negative | Duplicate email | Throws `DuplicateEmailError` | High |
| TC-003 | Unit | Negative | Password < 8 chars | Throws `ValidationError` | High |
| TC-004 | Unit | Negative | Password no uppercase | Throws `ValidationError` | High |
| TC-005 | Unit | Negative | Password no number | Throws `ValidationError` | High |
| TC-006 | Unit | Negative | Invalid email format | Throws `ValidationError` | High |
| TC-007 | Unit | Edge | Password exactly 8 chars (boundary) | Accepted | Medium |
| TC-008 | Unit | Edge | Name with unicode chars | Accepted | Low |
| TC-009 | Integration | Positive | Valid registration via POST /register | 201, user in DB, email mock called | High |
| TC-010 | Integration | Negative | Duplicate email via POST /register | 409, no duplicate in DB | High |
| TC-011 | Integration | Negative | Missing required field | 400 with field-level errors | High |

**Unit Test Skeleton**

```typescript
describe('UserService.register', () => {
  it('TC-001: creates user with hashed password', async () => { ... });
  it('TC-002: throws DuplicateEmailError for existing email', async () => { ... });
  it('TC-003: throws ValidationError for short password', async () => { ... });
  it('TC-007: accepts password of exactly 8 characters', async () => { ... });
});
```

**Integration Test Skeleton**

```typescript
describe('POST /api/register', () => {
  it('TC-009: 201 with valid data, user persisted', async () => { ... });
  it('TC-010: 409 for duplicate email', async () => { ... });
  it('TC-011: 400 with validation errors for missing fields', async () => { ... });
});
```
