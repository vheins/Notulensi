# Example Input: flaky-test-diagnosis

## Example 1: Flaky integration test

| Variable | Value |
|----------|-------|
| `{{flaky_test_code}}` | `it('sends welcome email after registration')` — fails ~20% of runs in CI with "Expected mock to be called once, but was called 0 times" |
| `{{tech_stack}}` | Node.js + Jest + supertest |
| `{{context}}` | Email is sent via background job (BullMQ). Test asserts mock was called immediately after POST /register response. Fails only in CI (4 parallel workers). |
