# Example Input: memory-leak-detection

### Example 1: Node.js + Express + EventEmitter
**Input:**
- `{{tech_stack}}`: Node.js + Express
- `{{code}}`: `app.get('/stream', (req, res) => { emitter.on('data', (chunk) => res.write(chunk)); });`
- `{{symptoms}}`: Memory grows ~50MB per hour under moderate traffic; Node.js process crashes after ~8 hours with heap OOM
- `{{profiling_data}}`: Heap snapshot shows EventEmitter listener count growing linearly with request count


### Example 2: Java + Spring Boot + Scheduled Tasks
**Input:**
- `{{tech_stack}}`: Java + Spring Boot
- `{{code}}`: `@Scheduled(fixedRate = 1000) public void process() { List<Event> events = new ArrayList<>(); cache.put(Thread.currentThread().getName(), events); }`
- `{{symptoms}}`: Heap grows 10MB/minute; GC runs frequently but cannot reclaim; OutOfMemoryError after 30 minutes
- `{{profiling_data}}`: JVisualVM shows HashMap in cache growing unboundedly; keys are thread names from thread pool`
