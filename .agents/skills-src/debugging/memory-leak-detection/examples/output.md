# Example Output: memory-leak-detection

**Expected Output Shape:**
```
1. Leak Pattern Identification
Event listener accumulation — a new listener is added to the emitter on every request but never removed when the response ends.

2. Leak Source
app.get('/stream') handler: emitter.on('data', ...) adds a listener per request. When the response closes, the listener remains attached, holding a reference to the res object and its closure scope.

3. Fix
Before:
  emitter.on('data', (chunk) => res.write(chunk));

After:
  const handler = (chunk) => res.write(chunk);
  emitter.on('data', handler);
  res.on('close', () => emitter.removeListener('data', handler));  // cleanup on disconnect

4. Profiling Guidance
  node --inspect app.js
  # In Chrome DevTools → Memory → Take Heap Snapshot
  # Load test: wrk -t4 -c100 -d60s http://localhost:3000/stream
  # Take second snapshot, compare: filter by EventEmitter, check listener count

5. Prevention Pattern
Always pair emitter.on() with a cleanup call in the request/connection close handler. Use emitter.once() for single-use listeners. Set emitter.setMaxListeners(20) to get early warnings.
```


**Expected Output Shape:**
```
1. Leak Pattern Identification
Static/long-lived collection growth — a shared cache Map is populated on every scheduled execution but never evicted.

2. Leak Source
The cache Map retains all Event lists ever created. Thread pool reuses thread names, so keys are bounded, but the ArrayList values grow with each execution cycle and are never cleared.

3. Fix
Before:
  cache.put(Thread.currentThread().getName(), events);

After:
  // Option A: Clear before use
  cache.put(Thread.currentThread().getName(), new ArrayList<>());
  // Option B: Use a bounded cache
  private final Cache<String, List<Event>> cache = Caffeine.newBuilder().maximumSize(100).expireAfterWrite(5, MINUTES).build();

4. Profiling Guidance
  # JVM flags for heap dump on OOM:
  -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/tmp/heap.hprof
  # Analyze with Eclipse MAT: look for Retained Heap on HashMap entries

5. Prevention Pattern
Never use unbounded collections as long-lived caches. Use Caffeine or Guava Cache with size and TTL limits. Annotate cache fields with @VisibleForTesting to enable inspection in tests.
```
