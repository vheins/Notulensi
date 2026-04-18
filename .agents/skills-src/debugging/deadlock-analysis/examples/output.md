# Example Output: deadlock-analysis

**Expected Output Shape:**
```
1. Deadlock Identification
Thread A holds accountA lock, waits for accountB lock.
Thread B holds accountB lock, waits for accountA lock.
Circular wait confirmed.

2. Resource Allocation Graph
Thread A → accountB → Thread B → accountA → Thread A (cycle)

3. Lock Ordering Issue
Thread A acquires locks in order: accountA → accountB
Thread B acquires locks in order: accountB → accountA
When both threads run concurrently, each holds the first lock and waits for the second.

4. Fix: Consistent Lock Ordering
Before:
  // Thread A: lock(accountA) then lock(accountB)
  // Thread B: lock(accountB) then lock(accountA)

After:
  // Always lock the lower account ID first
  Account first = a.getId() < b.getId() ? a : b;
  Account second = a.getId() < b.getId() ? b : a;
  synchronized(first) { synchronized(second) { transfer(a, b); } }

5. Prevention Strategy
Document a lock ordering policy: always acquire locks in ascending object ID order.
Add a LockOrderingValidator in CI that scans for nested synchronized blocks and verifies ordering.
```


**Expected Output Shape:**
```
1. Deadlock Identification (inferred from code)
Worker 1 acquires db_lock first, then file_lock.
Worker 2 acquires file_lock first, then db_lock.
Circular wait: Worker 1 holds db_lock waiting for file_lock; Worker 2 holds file_lock waiting for db_lock.

2. Resource Allocation Graph
Worker 1 → file_lock → Worker 2 → db_lock → Worker 1 (cycle)

3. Lock Ordering Issue
The two workers acquire the same two locks in opposite order. This is a classic lock inversion.

4. Fix
Before:
  # Worker 1: db_lock → file_lock
  # Worker 2: file_lock → db_lock

After:
  # Both workers: always acquire db_lock before file_lock
  with db_lock:
    with file_lock:
      perform_operation()

Alternative: Use threading.RLock with timeout:
  if db_lock.acquire(timeout=5):
    if file_lock.acquire(timeout=5):
      try: perform_operation()
      finally: file_lock.release(); db_lock.release()
    else: db_lock.release(); raise DeadlockError

5. Prevention Strategy
Establish a lock acquisition order document. Use a LockHierarchy class that raises an error if locks are acquired out of order. Add py-spy to CI to detect thread hangs in integration tests.
```
