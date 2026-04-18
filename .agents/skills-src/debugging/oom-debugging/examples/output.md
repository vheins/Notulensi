# Example Output: oom-debugging

**Expected Output Shape:**
```
1. OOM Classification
Heap OOM — JavaScript heap exhausted. 2.1GB Array + 300MB Buffer from JSON.stringify exceeds the default 1.5GB Node.js heap limit.

2. Memory Hog Identification
The /export route loads all database records into a single Array (2.1GB), then JSON.stringify creates a second copy as a Buffer (300MB). Total: ~2.4GB for a single request.

3. Fix
Before:
  const data = await db.findAll();
  res.json(data);

After (streaming):
  res.setHeader('Content-Type', 'application/json');
  res.write('[');
  let first = true;
  for await (const record of db.findAllStream()) {
    if (!first) res.write(',');
    res.write(JSON.stringify(record));
    first = false;
  }
  res.write(']');
  res.end();

4. Heap Configuration
Increase heap as a temporary measure while fixing the streaming:
  node --max-old-space-size=4096 app.js  # 4GB heap

Long-term: streaming eliminates the need for large heap.

5. Monitoring
Alert: process.memoryUsage().heapUsed / process.memoryUsage().heapTotal > 0.8
Add: --expose-gc flag + periodic gc() call to force GC before heap snapshot
```


**Expected Output Shape:**
```
1. OOM Classification
Metaspace OOM — JVM Metaspace (class metadata storage) exhausted. 45,000 dynamically loaded Groovy classes fill the 256MB Metaspace limit.

2. Memory Hog Identification
A new GroovyShell is created per request, each loading a new class into Metaspace. Classes are never unloaded because the GroovyClassLoader is not garbage collected (held by the shell reference).

3. Fix
Before:
  GroovyShell shell = new GroovyShell();  // new shell per request
  Script script = shell.parse(templateCode);

After (cache compiled scripts):
  private final Map<String, Script> scriptCache = new ConcurrentHashMap<>();
  Script script = scriptCache.computeIfAbsent(templateCode,
    code -> new GroovyShell().parse(code));  // compile once, reuse

4. Heap Configuration
Increase Metaspace as a temporary measure:
  -XX:MaxMetaspaceSize=512m

Long-term: script caching eliminates repeated class loading.
Monitor: -XX:+PrintGCDetails to see Metaspace GC events

5. Monitoring
JMX metric: java.lang:type=MemoryPool,name=Metaspace → Usage → used
Alert when Metaspace usage > 80% of MaxMetaspaceSize
```
