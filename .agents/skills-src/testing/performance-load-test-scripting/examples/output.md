# Example Output: performance-load-test-scripting

## Example 1: Product listing API

```javascript
// scripts/load-test-products.js
import http from 'k6/http';
import { check, sleep } from 'k6';
import { Rate, Trend } from 'k6/metrics';

const errorRate = new Rate('errors');
const responseTime = new Trend('response_time', true);

export const options = {
  stages: [
    { duration: '2m', target: 100 },   // ramp up
    { duration: '10m', target: 500 },  // steady state
    { duration: '2m', target: 0 },     // ramp down
  ],
  thresholds: {
    http_req_duration: ['p(95)<300'],   // P95 < 300ms
    errors: ['rate<0.001'],             // error rate < 0.1%
    http_req_failed: ['rate<0.001'],
  },
};

const BASE_URL = __ENV.BASE_URL || 'http://localhost:3000';

export default function () {
  const page = Math.floor(Math.random() * 10) + 1;
  const res = http.get(`${BASE_URL}/api/products?page=${page}&limit=20`, {
    headers: { 'Accept': 'application/json' },
  });

  const success = check(res, {
    'status is 200': (r) => r.status === 200,
    'response has data array': (r) => JSON.parse(r.body).data !== undefined,
    'response time < 500ms': (r) => r.timings.duration < 500,
  });

  errorRate.add(!success);
  responseTime.add(res.timings.duration);

  sleep(1);
}

export function handleSummary(data) {
  return {
    'results/load-test-summary.json': JSON.stringify(data, null, 2),
  };
}
```

Run: `k6 run --env BASE_URL=https://staging.example.com scripts/load-test-products.js`

**Expected Results at 500 VUs**

| Metric | Target | Typical Result |
|--------|--------|----------------|
| P95 latency | <300ms | ~180ms (with DB index on category+status) |
| Error rate | <0.1% | ~0% |
| Throughput | — | ~450 req/s |

**If P95 exceeds target:** Check `EXPLAIN ANALYZE` on the products query — likely missing composite index on `(status, category_id, created_at)`.
