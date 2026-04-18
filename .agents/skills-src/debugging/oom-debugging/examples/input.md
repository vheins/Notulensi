# Example Input: oom-debugging

### Example 1: Node.js — Large JSON Response Buffering
**Input:**
- `{{tech_stack}}`: Node.js + Express
- `{{error_message}}`: `FATAL ERROR: CALL_AND_RETRY_LAST Allocation failed - JavaScript heap out of memory`
- `{{heap_dump}}`: `Top retained objects:\n1. Array (2.1GB) - allocated in /app/routes/export.js:45\n2. Buffer (300MB) - allocated in JSON.stringify`
- `{{code}}`: `app.get('/export', async (req, res) => { const data = await db.findAll(); res.json(data); });`


### Example 2: Java — Metaspace OOM from Dynamic Class Loading
**Input:**
- `{{tech_stack}}`: Java 17 + Spring Boot
- `{{error_message}}`: `java.lang.OutOfMemoryError: Metaspace`
- `{{heap_dump}}`: `Metaspace usage: 512MB (limit: 256MB)\nTop class loaders: GroovyClassLoader (45,000 classes loaded)`
- `{{code}}`: `// Template engine evaluates Groovy scripts dynamically\nGroovyShell shell = new GroovyShell();\nScript script = shell.parse(templateCode);  // called on every request`
