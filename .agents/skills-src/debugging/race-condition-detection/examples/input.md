# Example Input: race-condition-detection

### Example 1: Go + goroutines
**Input:**
- `{{tech_stack}}`: Go
- `{{code}}`: `var counter int\nfunc increment() { counter++ }\nfunc main() { for i := 0; i < 1000; i++ { go increment() } }`
- `{{symptoms}}`: Final counter value is non-deterministic; sometimes 987, sometimes 1000, sometimes 943
- `{{context}}`: 1000 goroutines each increment a shared counter; expected final value is 1000


### Example 2: Java + Spring + ThreadPoolExecutor
**Input:**
- `{{tech_stack}}`: Java + Spring Boot
- `{{code}}`: `private Map<String, Session> sessions = new HashMap<>();\npublic void addSession(String id, Session s) { sessions.put(id, s); }\npublic Session getSession(String id) { return sessions.get(id); }`
- `{{symptoms}}`: ConcurrentModificationException thrown intermittently; sessions occasionally return null for known-good IDs
- `{{context}}`: Multiple request handler threads access the sessions map concurrently; Spring's default thread pool has 10 threads
