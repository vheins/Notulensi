# Example Input: observability-monitoring-test

## Example 1: Express API with OpenTelemetry

| Variable | Value |
|----------|-------|
| `{{observability_setup}}` | OpenTelemetry traces exported to Jaeger, Prometheus metrics via prom-client, structured JSON logs via pino |
| `{{tech_stack}}` | Node.js + Express + OpenTelemetry + Prometheus + pino |
| `{{instrumentation_code}}` | HTTP request middleware adds `requestId` to logs and starts trace span; DB queries tracked via Prisma instrumentation |
