# Example Output: system-design-review

**Expected Output Shape:**
```
1. Scalability Assessment
Finding: Single VM deployment cannot scale horizontally.
Risk: At 10k users, a single Node.js process will hit CPU/memory limits with no path to scale.
Recommendation: Containerize with Docker; deploy to ECS or Railway with auto-scaling.
Priority: High

Finding: Local disk file storage is not portable across instances.
Risk: Files become inaccessible when scaling to multiple instances.
Recommendation: Migrate file storage to S3 or equivalent object storage immediately.
Priority: Critical

2. Reliability Gaps
Finding: No database backup strategy documented.
Risk: Data loss on VM failure or accidental deletion.
Recommendation: Enable automated daily backups with 7-day retention; test restore procedure.
Priority: Critical

Finding: No circuit breaker or retry logic for external API calls.
Risk: Cascading failures if a third-party service becomes slow or unavailable.
Recommendation: Add exponential backoff retry with circuit breaker (e.g., opossum library).
Priority: Medium

3. Maintainability Issues
Finding: No structured logging or distributed tracing.
Risk: Debugging production issues requires SSH access and manual log grep.
Recommendation: Add structured JSON logging (Winston/Pino) + ship to CloudWatch or Datadog.
Priority: High

4. Security Concerns
Finding: 30-day JWT expiry with no refresh token rotation.
Risk: Stolen tokens remain valid for 30 days with no revocation mechanism.
Recommendation: Reduce access token expiry to 15 minutes; implement refresh token rotation.
Priority: Critical

Finding: No input validation middleware.
Risk: SQL injection and XSS vulnerabilities in unvalidated endpoints.
Recommendation: Add Zod or Joi validation on all request bodies and query parameters.
Priority: Critical

5. Recommendations Table
| Priority | Area | Recommendation | Effort |
|----------|------|----------------|--------|
| Critical | Storage | Migrate to S3 | S |
| Critical | Security | Add input validation | M |
| Critical | Security | Fix JWT expiry + refresh tokens | M |
| Critical | Reliability | Enable DB backups | S |
| High | Scalability | Containerize + auto-scale | L |
| High | Maintainability | Add structured logging | M |

Top 3 Actions: 1) Migrate file storage to S3 (blocks scaling). 2) Add input validation (security risk). 3) Fix JWT token strategy (active security vulnerability).
```


**Expected Output Shape:**
```
1. Scalability Assessment
Finding: Shared PostgreSQL database creates a coupling bottleneck.
Risk: Schema changes in one service break others; connection pool exhaustion at 200k DAU.
Recommendation: Migrate to database-per-service pattern; use event-driven communication for cross-service data.
Priority: High

2. Reliability Gaps
Finding: Synchronous HTTP calls between services create cascading failure risk.
Risk: If Service A is slow, all services calling A become slow or fail.
Recommendation: Add circuit breakers (e.g., resilience4j or tenacity); consider async messaging for non-critical paths.
Priority: High

3. Maintainability Issues
Finding: No distributed tracing across service calls.
Risk: Debugging a request that spans 3+ services requires correlating logs manually.
Recommendation: Add OpenTelemetry instrumentation; ship traces to Jaeger or Datadog APM.
Priority: High

4. Security Concerns
Finding: No service-to-service authentication.
Risk: Any service on the cluster can call any other service without authorization.
Recommendation: Implement mutual TLS (mTLS) via service mesh (Istio or Linkerd) or API key per service.
Priority: Critical

Top 3 Actions: 1) Add mTLS for service-to-service auth. 2) Add distributed tracing. 3) Plan database-per-service migration.
```
