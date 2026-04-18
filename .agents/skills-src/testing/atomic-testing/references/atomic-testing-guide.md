# References: atomic-testing

## Atomic Test Workflow

Run tests one file at a time. Fix failures immediately before moving to the next file.

```
for each test file:
  1. Run the file
  2. If all pass → move to next file
  3. If any fail → analyze root cause → apply minimal fix → re-run → confirm pass
  4. Commit fix before moving on
```

## Idempotency Requirement

Every fix applied during atomic testing must be idempotent:
- Running the same test twice must produce the same result
- Tests must not depend on execution order
- State must be reset between test runs

## Common Failure Patterns

| Pattern | Symptom | Fix |
|---------|---------|-----|
| Missing mock | `TypeError: undefined is not a function` | Add mock for the dependency |
| State leak | Test passes alone, fails in suite | Reset state in `beforeEach`/`afterEach` |
| Async not awaited | Test passes but assertion never runs | Add `await` or return the promise |
| Wrong assertion | Test passes with wrong value | Check expected vs actual carefully |

## Test Runner Quick Reference

| Runner | Run single file | Run with pattern |
|--------|----------------|-----------------|
| Jest | `npx jest path/to/file.test.ts` | `npx jest --testPathPattern=auth` |
| pytest | `pytest tests/test_auth.py` | `pytest -k "auth"` |
| Go test | `go test ./auth/...` | `go test -run TestAuth ./...` |
| Cargo | `cargo test auth` | `cargo test -- --test-thread=1` |
