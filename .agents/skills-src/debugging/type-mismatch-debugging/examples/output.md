# Example Output: type-mismatch-debugging

**Expected Output Shape:**
```
1. Type Conflict Identification
Expected: age: number
Actual: age: string (JSON serialized as "25")
Location: assignment of API response to User interface

2. Type System Behavior
TypeScript's type system trusts the declared return type of .json() (which is any). The mismatch is not caught at compile time — it surfaces at runtime when number operations fail on a string.

3. Fix
Before:
  const user: User = await fetch('/api/user').then(r => r.json());

After (with Zod validation):
  const UserSchema = z.object({ age: z.coerce.number() });  // coerce string to number
  const user = UserSchema.parse(await fetch('/api/user').then(r => r.json()));

4. Schema Alignment
const UserSchema = z.object({
  age: z.coerce.number(),  // handles "25" → 25
  name: z.string(),
});
type User = z.infer<typeof UserSchema>;  // derive TypeScript type from schema

5. Prevention
Add Zod validation at all API boundaries. Enable TypeScript strict mode. Never use type assertions on API responses.
```


**Expected Output Shape:**
```
1. Type Conflict Identification
Expected: string (database layer GetUser parameter)
Actual: int64 (Protobuf-generated GetUserId() return type)
Location: function call argument at service-to-repository boundary

2. Type System Behavior
Go's static type system rejects implicit numeric-to-string conversion. The mismatch reveals a design inconsistency: Protobuf uses int64 IDs while the database uses string UUIDs.

3. Fix
Option A: Convert at the boundary (short-term)
  userIDStr := strconv.FormatInt(userID, 10)
  user, err := db.GetUser(userIDStr)

Option B: Align the types (recommended)
  // Update Protobuf definition to use string:
  // string user_id = 1;
  // Then GetUserId() returns string directly

4. Schema Alignment
Update user.proto:
  message GetUserRequest {
    string user_id = 1;  // changed from int64 to string
  }
Regenerate protobuf bindings. Update all callers.

5. Prevention
Define a canonical ID type in a shared types package. Use a linter rule to flag int64-to-string conversions at service boundaries. Add integration tests that validate the full request/response type chain.
```
