# Example Input: type-mismatch-debugging

### Example 1: TypeScript + Zod + REST API
**Input:**
- `{{tech_stack}}`: TypeScript + Zod + React
- `{{error_message}}`: `Type 'string' is not assignable to type 'number'. Property 'age' expected number, got string`
- `{{code}}`: `interface User { age: number }\nconst user: User = await fetch('/api/user').then(r => r.json());`
- `{{context}}`: The API returns age as a JSON string ("25") but the TypeScript interface declares it as number


### Example 2: Go + gRPC + Protobuf
**Input:**
- `{{tech_stack}}`: Go + gRPC + Protobuf
- `{{error_message}}`: `cannot use userID (type int64) as type string in argument to GetUser`
- `{{code}}`: `userID := req.GetUserId()  // returns int64\nuser, err := db.GetUser(userID)  // expects string`
- `{{context}}`: Protobuf defines user_id as int64; the database layer uses string UUIDs; mismatch at the service boundary
