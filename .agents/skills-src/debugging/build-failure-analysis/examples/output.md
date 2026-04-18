# Example Output: build-failure-analysis

**Expected Output Shape:**
```
1. Error Classification
Compilation errors — two TypeScript type errors:
- TS2339: Property 'profile' does not exist on User type (missing field in interface)
- TS2322: Type 'string | undefined' not assignable to 'string' (optional field not handled)

2. Root Cause
Root error: User interface in src/types/user.ts is missing the profile field.
Cascading error: Once profile is added as optional, the string | undefined type mismatch must also be fixed.

3. Fix Steps
Step 1: Add profile to User interface in src/types/user.ts:
  interface User {
    id: string;
    name: string;
    profile?: { name?: string; avatar?: string };  // add optional profile
  }

Step 2: Fix the type mismatch in UserCard.tsx:
  Before: name={user.profile?.name}
  After:  name={user.profile?.name ?? 'Anonymous'}  // provide fallback for undefined

Step 3: Verify:
  npx tsc --noEmit  # type-check without building
  npm run build     # full build

4. Clean Build
Not needed — this is a type error, not a dependency or cache issue.

5. CI/CD
TypeScript errors are deterministic — if it fails locally it will fail in CI. Ensure CI runs npx tsc --noEmit as a separate check step before the build.
```


**Expected Output Shape:**
```
1. Error Classification
Compilation error — cannot find symbol: UserRepository. The class exists but the import statement points to the old package path.

2. Root Cause
UserRepository was moved from com.app.service to com.app.repository but the import in UserService.java was not updated.

3. Fix Steps
Step 1: Update import in UserService.java:
  Before: import com.app.service.UserRepository;
  After:  import com.app.repository.UserRepository;

Step 2: Check for other files that import from the old package:
  grep -r "com.app.service.UserRepository" src/

Step 3: Verify:
  mvn compile  # compile only, faster than full build
  mvn test     # run tests to confirm no regressions

4. Clean Build
If the error persists after fixing the import:
  mvn clean compile  # clean removes target/ directory with cached class files

5. CI/CD
Maven builds are deterministic. If the import is fixed locally, CI will pass. Ensure CI uses mvn clean install (not just mvn install) to avoid stale class file issues.
```
