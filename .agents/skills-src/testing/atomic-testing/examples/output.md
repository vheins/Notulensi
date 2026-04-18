# Example Output: atomic-testing

## Atomic Test Run: tests/services/ (pytest)

### Execution Log

```
Running: pytest tests/services/test_order_service.py
✅ PASS  test_create_order_happy_path
✅ PASS  test_create_order_insufficient_stock
❌ FAIL  test_create_order_invalid_user

FAILED tests/services/test_order_service.py::test_create_order_invalid_user
AssertionError: Expected 404, got 500
```

### Failure Analysis

| File | Test | Status | Root Cause |
|------|------|--------|-----------|
| `test_order_service.py` | `test_create_order_invalid_user` | ❌ FAIL | `OrderService.create()` raises unhandled `UserNotFound` exception instead of returning 404 |

### Fix Applied

```python
# Before (order_service.py:34)
user = User.objects.get(id=user_id)  # raises DoesNotExist

# After
try:
    user = User.objects.get(id=user_id)
except User.DoesNotExist:
    raise UserNotFoundException(f"User {user_id} not found")
```

### Re-run Result

```
Running: pytest tests/services/test_order_service.py
✅ PASS  test_create_order_happy_path
✅ PASS  test_create_order_insufficient_stock
✅ PASS  test_create_order_invalid_user

3 passed in 0.42s
```

### Summary

| Metric | Value |
|--------|-------|
| Files tested | 1 |
| Tests run | 3 |
| Passed | 3 |
| Failed | 0 |
| Fixes applied | 1 |
