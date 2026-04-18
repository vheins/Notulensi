# Example Input: deadlock-analysis

### Example 1: Java + Spring Boot
**Input:**
- `{{tech_stack}}`: Java + Spring Boot
- `{{code}}`: `// Thread A: synchronized(accountA) { synchronized(accountB) { transfer(a,b); } }\n// Thread B: synchronized(accountB) { synchronized(accountA) { transfer(b,a); } }`
- `{{thread_dump}}`: `Thread A: BLOCKED on accountB (held by Thread B)\nThread B: BLOCKED on accountA (held by Thread A)`
- `{{context}}`: Bank transfer service; two threads simultaneously transfer between the same two accounts in opposite directions


### Example 2: Python + threading + SQLite
**Input:**
- `{{tech_stack}}`: Python + threading + SQLite
- `{{code}}`: `# Worker 1: with db_lock: with file_lock: write_to_db_and_file()\n# Worker 2: with file_lock: with db_lock: read_from_file_and_db()`
- `{{thread_dump}}`: Not available — application hangs indefinitely under load
- `{{context}}`: Two worker threads process jobs; one writes to DB then file, the other reads from file then DB; deadlock occurs under concurrent load
