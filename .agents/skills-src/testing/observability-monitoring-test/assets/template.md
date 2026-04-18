# Observability & Monitoring Test Specification Template

> Fill in all fields before activating the `observability-monitoring-test` skill.

---

## Service Info

**Service:** `{{service-name}}`

**Tech Stack:** {{e.g. Node.js + Express, Python + FastAPI, Go + Gin}}

**Observability Stack:** {{e.g. Prometheus + Grafana, Datadog, OpenTelemetry + Jaeger}}

---

## Metrics to Test

| Metric Name | Type | Labels | Expected Behavior |
|-------------|------|--------|-------------------|
| `{{e.g. http_requests_total}}` | counter | `method, path, status` | increments on each request |
| `{{e.g. http_request_duration_seconds}}` | histogram | `method, path` | records latency per request |
| `{{e.g. db_query_duration_seconds}}` | histogram | `query_type` | records DB query time |
| `{{e.g. active_connections}}` | gauge | — | reflects current connection count |
| `{{metric_name}}` | {{counter/gauge/histogram}} | `{{labels}}` | {{expected}} |

---

## Traces to Test

| Span Name | Parent | Expected Tags | Expected Duration |
|-----------|--------|---------------|-------------------|
| `{{e.g. http.request}}` | root | `http.method, http.url, http.status_code` | < {{e.g. 500ms}} |
| `{{e.g. db.query}}` | `http.request` | `db.statement, db.type` | < {{e.g. 100ms}} |
| `{{e.g. external.call}}` | `http.request` | `peer.service, http.url` | < {{e.g. 200ms}} |

---

## Logs to Test

| Log Event | Level | Required Fields | Condition |
|-----------|-------|-----------------|-----------|
| Request received | `info` | `requestId, method, path` | every request |
| Request completed | `info` | `requestId, statusCode, duration` | every response |
| Error occurred | `error` | `requestId, error, stack` | on 5xx |
| Slow query | `warn` | `query, duration` | duration > {{e.g. 500ms}} |

---

## Alerts to Validate

| Alert Name | Condition | Severity | Expected Action |
|------------|-----------|----------|-----------------|
| `{{e.g. HighErrorRate}}` | error rate > {{1%}} for {{5min}} | critical | page on-call |
| `{{e.g. SlowP95}}` | P95 > {{1s}} for {{10min}} | warning | notify team |
| `{{e.g. ServiceDown}}` | no requests for {{2min}} | critical | page on-call |

---

## Test Approach

**Metrics:** {{e.g. call endpoint, query Prometheus API, assert metric value}}

**Traces:** {{e.g. send request, query Jaeger/Zipkin, assert span structure}}

**Logs:** {{e.g. capture stdout, assert JSON fields present}}
