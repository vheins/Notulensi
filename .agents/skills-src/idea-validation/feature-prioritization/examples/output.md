# Example Output: feature-prioritization

## Scenario: RICE Scoring — B2B SaaS Features

> Output yang dihasilkan ketika diberikan input dari `input.md`

```
RICE Scoring Table (sorted by score):
| Feature | Reach | Impact | Confidence | Effort (weeks) | RICE Score |
|---|---|---|---|---|---|
| Email delivery | 400 | 2 | 90% | 0.5 | 1440 |
| User authentication | 500 | 2 | 100% | 1 | 1000 |
| Report generation | 500 | 3 | 80% | 1.5 | 800 |
| Jira integration | 500 | 3 | 80% | 2 | 600 |
| Slack notification | 300 | 1 | 70% | 0.5 | 420 |
| GitHub integration | 500 | 2 | 80% | 2 | 400 |
| Team management | 150 | 2 | 70% | 3 | 70 |
| Custom templates | 200 | 1 | 60% | 2 | 60 |
| API access | 50 | 2 | 60% | 3 | 20 |
| Analytics dashboard | 100 | 1 | 50% | 4 | 12.5 |

Top 3 Quick Wins:
1. Email delivery (RICE: 1440) — High reach, low effort; delivers the core output to users immediately
2. User authentication (RICE: 1000) — Required for everything else; high confidence, low effort
3. Report generation (RICE: 800) — The product's core value; must be built first after auth

High-Effort Low-Impact Items:
- Analytics dashboard (RICE: 12.5) — High effort (4 weeks), low confidence, low reach → Defer to v2
- API access (RICE: 20) — Low reach for MVP stage → Defer until user base is established

Summary: Build auth → email delivery → report generation → Jira/GitHub integrations in that order. Defer analytics and API access until the core loop is validated with real users.
```
