# Example Output: error-analysis

**Expected Output Shape:**
```
1. Error Classification
Runtime error — TypeError caused by accessing a property on an undefined value.

2. Root Cause
At userService.js:42, the code accesses `user.id` but `user` is undefined because the DB query returned no rows for the given ID. The query result was not checked for null/undefined before property access.

3. Affected Component
userService.getUserById — blast radius includes any route that calls this service method without null-checking the return value.

4. Fix Recommendation
Before: return user.id;
After:
  if (!user) throw new NotFoundError(`User ${id} not found`);
  return user.id;

5. Test Case
it('throws NotFoundError when user does not exist', async () => {
  await expect(getUserById('nonexistent-id')).rejects.toThrow(NotFoundError);
});
```


**Expected Output Shape:**
```
1. Error Classification
Runtime error — database IntegrityError caused by a unique constraint violation on the email column.

2. Root Cause
crud/user.py:28 commits a new user without first checking whether the email already exists. The database enforces uniqueness but the application layer does not guard against duplicates.

3. Affected Component
create_user in crud/user.py — blast radius: any endpoint that creates users without pre-validation.

4. Fix Recommendation
Add a pre-insert existence check:
  existing = db.query(User).filter(User.email == user.email).first()
  if existing:
      raise HTTPException(status_code=409, detail="Email already registered")

5. Test Case
def test_create_duplicate_user(client, db):
    client.post("/users", json={"email": "a@b.com"})
    response = client.post("/users", json={"email": "a@b.com"})
    assert response.status_code == 409
```
