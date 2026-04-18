# Example Input: build-failure-analysis

### Example 1: TypeScript + tsc + Next.js
**Input:**
- `{{tech_stack}}`: TypeScript + Next.js + tsc
- `{{build_output}}`: `./src/components/UserCard.tsx:15:5 - error TS2322: Type 'string | undefined' is not assignable to type 'string'.\n  15     name={user.profile?.name}\n         ~~~~\n./src/types/user.ts:8:3 - error TS2339: Property 'profile' does not exist on type 'User'.`
- `{{context}}`: Added optional profile field to User type; forgot to update the TypeScript interface


### Example 2: Java + Maven + Spring Boot
**Input:**
- `{{tech_stack}}`: Java 17 + Maven + Spring Boot 3
- `{{build_output}}`: `[ERROR] COMPILATION ERROR:\n[ERROR] /src/main/java/com/app/service/UserService.java:[45,8] error: cannot find symbol\n  symbol:   class UserRepository\n  location: class UserService\n[ERROR] BUILD FAILURE`
- `{{context}}`: Moved UserRepository to a new package com.app.repository; forgot to update the import in UserService
