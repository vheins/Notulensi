# Example Input: performance-bottleneck-analysis

### Example 1: Go + gRPC + PostgreSQL
**Input:**
- `{{tech_stack}}`: Go + gRPC + PostgreSQL
- `{{performance_profile}}`: pprof flame graph shows 65% of CPU time in json.Marshal; DB queries average 2ms; p99 latency is 450ms vs SLA of 100ms
- `{{code}}`: `func GetUser(id string) (*User, error) { user := fetchFromDB(id); return json.Marshal(user) }`
- `{{context}}`: 500 RPS, read-heavy workload, user objects are ~2KB, no caching layer


### Example 2: Python + Django + Celery + Redis
**Input:**
- `{{tech_stack}}`: Python + Django + Celery + Redis
- `{{performance_profile}}`: New Relic trace shows 78% of request time in ORM queries; N+1 query pattern detected on /api/posts endpoint; average 47 queries per request
- `{{code}}`: `posts = Post.objects.filter(published=True); return [{'title': p.title, 'author': p.author.name} for p in posts]`
- `{{context}}`: Blog platform, 200 RPS, posts endpoint called on every page load, average 50 posts per page
