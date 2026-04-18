# Example Output: observability-monitoring-test

## Example 1: Express API with OpenTelemetry

**Metrics Tests**

```typescript
import request from 'supertest';
import app from '../app';
import { register } from 'prom-client';

describe('Prometheus metrics', () => {
  it('increments http_requests_total on each request', async () => {
    await request(app).get('/api/products');
    const metrics = await register.metrics();
    expect(metrics).toMatch(/http_requests_total{.*method="GET".*path="\/api\/products".*} [1-9]/);
  });

  it('records http_request_duration_seconds histogram', async () => {
    await request(app).get('/api/products');
    const metrics = await register.metrics();
    expect(metrics).toMatch(/http_request_duration_seconds_bucket/);
  });

  it('exposes /metrics endpoint', async () => {
    const res = await request(app).get('/metrics');
    expect(res.status).toBe(200);
    expect(res.text).toContain('http_requests_total');
  });
});
```

**Trace Tests**

```typescript
import { trace, context } from '@opentelemetry/api';
import { InMemorySpanExporter } from '@opentelemetry/sdk-trace-base';

const exporter = new InMemorySpanExporter();

describe('OpenTelemetry traces', () => {
  beforeEach(() => exporter.reset());

  it('creates root span for HTTP request', async () => {
    await request(app).get('/api/products');
    const spans = exporter.getFinishedSpans();
    const rootSpan = spans.find(s => s.name === 'GET /api/products');
    expect(rootSpan).toBeDefined();
    expect(rootSpan!.attributes['http.method']).toBe('GET');
    expect(rootSpan!.attributes['http.status_code']).toBe(200);
  });

  it('creates child span for DB query', async () => {
    await request(app).get('/api/products');
    const spans = exporter.getFinishedSpans();
    const dbSpan = spans.find(s => s.name.includes('prisma'));
    expect(dbSpan).toBeDefined();
  });
});
```

**Log Tests**

```typescript
import { captureOutput } from './helpers/log-capture';

describe('Structured logging', () => {
  it('logs requestId on every request', async () => {
    const logs = await captureOutput(() => request(app).get('/api/products'));
    const requestLog = logs.find(l => l.msg === 'request received');
    expect(requestLog?.requestId).toMatch(/^[0-9a-f-]{36}$/); // UUID
  });

  it('logs statusCode and duration on response', async () => {
    const logs = await captureOutput(() => request(app).get('/api/products'));
    const responseLog = logs.find(l => l.msg === 'request completed');
    expect(responseLog?.statusCode).toBe(200);
    expect(typeof responseLog?.duration).toBe('number');
  });
});
```
