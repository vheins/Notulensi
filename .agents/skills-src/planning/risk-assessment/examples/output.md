# Example Output: risk-assessment

**Expected Output Shape:**
```
1. Risk Matrix
| Risk | Category | Likelihood | Impact | Score | Mitigation |
|------|----------|-----------|--------|-------|------------|
| Scope creep delays MVP | Technical | 4 | 4 | 16 | Strict MoSCoW prioritization; weekly scope review |
| Auth0 pricing change | Operational | 3 | 4 | 12 | Abstract auth layer; evaluate alternatives at 1k users |
| Stripe integration complexity | Technical | 3 | 4 | 12 | Spike in week 1; use Stripe Checkout to reduce scope |
| No paying customers at launch | Business | 3 | 5 | 15 | Start sales outreach in month 2; target 5 LOIs before launch |
| Key engineer leaves | Operational | 2 | 5 | 10 | Document architecture; cross-train on critical paths |
| AWS outage | Operational | 2 | 4 | 8 | Multi-AZ deployment; status page; SLA communication plan |
| Security breach (data leak) | Technical | 2 | 5 | 10 | Penetration test before launch; encrypt PII at rest |
| Beta feedback requires major rework | Business | 3 | 4 | 12 | Timebox beta feedback; separate "must fix" from "nice to have" |

2. Top 5 Critical Risks
Risk 1: Scope creep delays MVP (Score: 16)
Root cause: No formal change control process; stakeholder requests added mid-sprint.
Early warning signs: Sprint velocity drops; backlog grows faster than it shrinks.
Mitigation: Weekly backlog review; any new feature requires removing an existing one.
Contingency: Cut to absolute minimum viable feature set; delay non-core features to v1.1.
Owner: PM

Risk 2: No paying customers at launch (Score: 15)
Root cause: Product built without validated demand; no sales pipeline.
Early warning signs: Beta users not converting to paid; no LOIs by month 4.
Mitigation: Start outbound sales in month 2; target 5 signed LOIs before launch.
Contingency: Extend runway; pivot pricing model; offer extended free trial.
Owner: PM + Founders

3. Risk Monitoring Plan
Review cadence: Weekly risk review in sprint retrospective; full risk matrix review at each milestone.
Escalation criteria: Any risk score increases by 4+ points; any Critical risk materializes.
Risk register: Maintained in project management tool; risks closed when mitigation is confirmed effective.
Key metrics: Sprint velocity (scope creep indicator); sales pipeline size (business risk indicator); error rate in staging (technical risk indicator).
```


**Expected Output Shape:**
```
1. Risk Matrix
| Risk | Category | Likelihood | Impact | Score | Mitigation |
|------|----------|-----------|--------|-------|------------|
| Legacy API changes break ingestion | Technical | 4 | 4 | 16 | Version-lock API calls; add schema validation on ingest |
| Fixed-price scope underestimated | Business | 4 | 5 | 20 | Detailed scope document with change order process |
| Data governance compliance failure | Operational | 3 | 5 | 15 | Engage client's compliance team in month 1 |
| Snowflake performance issues | Technical | 2 | 4 | 8 | Load test with production data volume in month 2 |
| UAT delays production cutover | Operational | 3 | 4 | 12 | Start UAT prep in month 2; define UAT acceptance criteria upfront |
| SFTP credential rotation breaks pipeline | Technical | 3 | 3 | 9 | Implement credential rotation handling; alert on auth failure |
| Client stakeholder unavailability | Operational | 3 | 4 | 12 | Identify backup contacts; document decisions in writing |
| Data quality issues from legacy systems | Technical | 4 | 3 | 12 | Add data quality checks at ingestion; quarantine bad records |

2. Top 5 Critical Risks
Risk 1: Fixed-price scope underestimated (Score: 20)
Root cause: Legacy system complexity often exceeds initial estimates.
Early warning signs: Month 1 integration taking 2x estimated time.
Mitigation: Detailed scope document signed before work begins; change order process for out-of-scope requests.
Contingency: Negotiate scope reduction or timeline extension; document all out-of-scope requests.
Owner: Project Manager

3. Risk Monitoring Plan
Review cadence: Weekly with internal team; bi-weekly with client stakeholder.
Escalation criteria: Any risk score ≥ 15 materializes; timeline slippage > 1 week.
Key metrics: Integration completion rate vs. plan; UAT defect count; data quality error rate.
```
