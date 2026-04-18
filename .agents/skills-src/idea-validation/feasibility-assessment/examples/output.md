# Example Output: feasibility-assessment

## Scenario: B2B SaaS — Solo Developer, Bootstrapped

> Output yang dihasilkan ketika diberikan input dari `input.md`

```
1. Technical Feasibility: 8/10
Both Jira and GitHub have well-documented REST APIs with generous free tiers. Next.js + Supabase is a proven stack for this type of SaaS. The main technical unknown is OAuth flow for Jira (Atlassian's OAuth 2.0 is more complex than standard flows). No fundamental technical blockers.
Technical risks: Jira OAuth complexity (Medium), API rate limits at scale (Low for MVP)

2. Financial Feasibility
| Cost Item | Estimate |
|---|---|
| Development (8 weeks × 40hrs × $0 opportunity cost) | $0 cash, ~320 hours |
| Vercel hosting (Hobby tier) | $0/month at launch |
| Supabase (Free tier) | $0/month up to 500MB |
| Jira API | Free |
| GitHub API | Free |
| Total at launch | $0/month |
| At 1,000 users | ~$50–100/month (Supabase Pro + Vercel Pro) |

Verdict: Feasible — infrastructure costs are negligible at MVP scale.

3. Time Feasibility
Estimated development time for Must Have features: 6–7 weeks for a solo developer.
Target timeline: 8 weeks.
Buffer: 1–2 weeks for testing and deployment.
Verdict: On Track — tight but achievable if scope is controlled.

4. Risk Matrix
| Risk | Dimension | Likelihood | Impact | Mitigation |
|---|---|---|---|---|
| Jira OAuth takes longer than expected | Technical | Medium | High | Spike on OAuth in week 1 |
| Scope creep adds features mid-build | Time | High | High | Lock scope before starting; use MoSCoW |
| Solo developer burnout | Time | Medium | High | Time-box to 6 hours/day max |
| Jira API changes break integration | Technical | Low | Medium | Pin API version; add monitoring |
| No paying customers after launch | Financial | Medium | High | Pre-sell to 3 customers before building |

5. Go/No-Go Recommendation: GO with Conditions
Proceed, but with two conditions: (1) Spike on Jira OAuth in week 1 to confirm it's achievable before committing to the full build. (2) Pre-sell to at least 3 engineering managers before writing production code to validate willingness to pay.
```
