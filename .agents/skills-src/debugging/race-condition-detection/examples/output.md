# Example Output: race-condition-detection

**Expected Output Shape:**
```
1. Race Condition Identification
Read-modify-write race — counter++ is not atomic; it compiles to three operations: LOAD, ADD, STORE.

2. Timing Window
Goroutine A          Goroutine B
LOAD counter (0)
                     LOAD counter (0)
ADD 1 → 1
STORE counter = 1
                     ADD 1 → 1
                     STORE counter = 1  ← lost increment

3. Fix
Before: var counter int; counter++
After (atomic): var counter int64; atomic.AddInt64(&counter, 1)
After (mutex):  var mu sync.Mutex; mu.Lock(); counter++; mu.Unlock()
Recommendation: Use atomic.AddInt64 — no lock overhead for simple counter.

4. Testing Strategy
go test -race ./...  # Go race detector
Stress test: run 10,000 goroutines, assert final value == 10,000

5. Performance Impact
atomic.AddInt64: ~2ns per operation, no contention overhead
sync.Mutex: ~25ns per operation under contention — avoid for high-frequency counters
```


**Expected Output Shape:**
```
1. Race Condition Identification
Concurrent collection access — HashMap is not thread-safe. Concurrent put() and get() operations cause internal structural corruption.

2. Timing Window
Thread A (put)              Thread B (get)
resize HashMap internal array
                            traverse internal array (stale pointer)
                            → ConcurrentModificationException or null

3. Fix
Before: private Map<String, Session> sessions = new HashMap<>();
After:  private Map<String, Session> sessions = new ConcurrentHashMap<>();
// ConcurrentHashMap uses lock striping — 16 independent locks for 16 segments
// No full-map lock needed for most operations

4. Testing Strategy
@Test void testConcurrentAccess() throws InterruptedException {
  ExecutorService pool = Executors.newFixedThreadPool(20);
  IntStream.range(0, 1000).forEach(i -> pool.submit(() -> sessions.put("key"+i, new Session())));
  pool.shutdown(); pool.awaitTermination(5, SECONDS);
  assertEquals(1000, sessions.size());
}

5. Performance Impact
ConcurrentHashMap: ~15% overhead vs HashMap in single-threaded use
Lock striping: scales well to 16 concurrent writers before contention
For read-heavy workloads: consider Collections.unmodifiableMap() with copy-on-write pattern
```
