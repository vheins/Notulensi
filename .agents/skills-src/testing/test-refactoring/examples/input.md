# Example Input: test-refactoring

## Example 1: Brittle, duplicated test suite

| Variable | Value |
|----------|-------|
| `{{test_code}}` | 3 describe blocks each with identical `beforeEach` setup (50 lines), magic strings like `"user123"`, tests asserting on internal mock call counts instead of behavior, test names like `"test 1"`, `"should work"` |
| `{{tech_stack}}` | TypeScript + Jest |
| `{{refactoring_goals}}` | reduce duplication, improve readability, fix brittleness |
