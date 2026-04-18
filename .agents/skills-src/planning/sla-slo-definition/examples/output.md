# Example Output: sla-slo-definition

**Expected Output Shape:**
```
1. SLI Definitions
Availability SLI: Percentage of HTTP requests to /api/checkout/* returning 2xx or 4xx (not 5xx) in a 5-minute rolling window. Source: Datadog APM request metrics.

Latency SLI: p95 response time for POST /api/checkout/complete in a 5-minute rolling window. Source: Datadog APM latency histogram.

Error Rate SLI: Percentage of POST /api/checkout/complete requests returning 5xx in a 5-minute rolling window. Source: Datadog APM error rate.

Payment Success SLI: Percentage of payment attempts that result in a successful charge (excluding user-initiated declines). Source: Stripe webhook events + application logs.

2. SLO Targets
| SLI | SLO Target | Window | Rationale |
|-----|-----------|--------|-----------|
| Availability | 99.9% | 30-day rolling | 4 hours downtime/year = 99.954%; 99.9% is conservative and achievable |
| Latency p95 | < 500ms | 30-day rolling | Business requirement; above 500ms cart abandonment increases significantly |
| Latency p99 | < 1500ms | 30-day rolling | Tail latency protection; 1500ms acceptable for edge cases |
| Error Rate | < 0.1% | 30-day rolling | Business requirement; 0.1% = 10 failed checkouts per 10k daily |
| Payment Success | > 99.5% | 30-day rolling | Stripe baseline; 0.5% accounts for legitimate card declines |

3. Error Budget Calculation
Availability (99.9%): 0.1% error budget = 43.8 minutes/month = 10.1 minutes/week
Latency p95 (< 500ms): 0.1% of requests may exceed 500ms = 864 requests/day at 1M req/day
Error Rate (< 0.1%): 0.1% of requests may be 5xx = 864 errors/day at 1M req/day

Burn rate examples (availability):
- 1x burn rate: budget depletes in 30 days (normal operation)
- 14.4x burn rate: budget depletes in 1 hour (major outage)
- 6x burn rate: budget depletes in 5 hours (significant degradation)

4. Alerting Thresholds
Alert 1: Critical Availability Burn (Page)
Condition: Burn rate > 14.4x for 5 minutes (1-hour window) AND burn rate > 6x for 1 hour (6-hour window)
Severity: Page — wake on-call engineer immediately
Rationale: At 14.4x burn rate, entire monthly budget depletes in 1 hour

Alert 2: High Latency Burn (Page)
Condition: p95 latency > 1000ms for 10 consecutive minutes
Severity: Page
Rationale: 2x SLO threshold sustained for 10 minutes indicates systemic issue

Alert 3: Slow Error Budget Burn (Ticket)
Condition: Burn rate > 2x for 6 hours (6-hour window)
Severity: Ticket — investigate next business day
Rationale: Gradual degradation that won't breach SLO immediately but needs investigation

5. Escalation Policy
On-call: Backend engineer on-call rotation (PagerDuty)
Escalation: If not acknowledged in 10 minutes → escalate to engineering lead
Stakeholder notification: If availability < 99% for > 15 minutes → notify VP Engineering and Head of Product
SLA breach: If monthly availability drops below 99.9% → customer success team notifies affected enterprise customers within 2 hours
Postmortem required: Any P1 incident (> 15 minutes downtime) or any SLO breach in a calendar month
```


**Expected Output Shape:**
```
1. SLI Definitions
Availability SLI: Percentage of HTTP requests returning non-5xx responses during business hours (9am–6pm local time). Source: Prometheus http_requests_total metric.

Latency SLI: p95 response time for GET /api/analytics/* during business hours. Source: Prometheus http_request_duration_seconds histogram.

2. SLO Targets
| SLI | SLO Target | Window | Rationale |
|-----|-----------|--------|-----------|
| Availability (business hours) | 99.5% | 30-day rolling (business hours only) | Internal tool; 99.5% = 2.2 hours downtime/month acceptable |
| Latency p95 | < 2000ms | 30-day rolling | Analytics queries are complex; 2s acceptable for non-real-time data |
| Error Rate | < 0.5% | 30-day rolling | Internal tool; higher tolerance than customer-facing |

3. Error Budget Calculation
Availability (99.5%, business hours only): 0.5% of ~180 business hours/month = 54 minutes/month error budget

4. Alerting Thresholds
Alert 1: Availability Degradation (Ticket — business hours only)
Condition: Error rate > 5% for 10 consecutive minutes during business hours
Severity: Ticket; notify on-call via OpsGenie (business hours only)

Alert 2: High Latency (Ticket)
Condition: p95 > 5000ms for 15 consecutive minutes during business hours
Severity: Ticket

5. Escalation Policy
On-call: Data engineering team (business hours only; no overnight paging)
Escalation: If not acknowledged in 30 minutes → escalate to data engineering lead
Postmortem: Required if downtime > 30 minutes during business hours
```
