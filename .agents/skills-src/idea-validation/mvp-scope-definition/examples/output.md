# Example Output: mvp-scope-definition

## Scenario: B2B SaaS — Engineering Status Reports

> Output yang dihasilkan ketika diberikan input dari `input.md`

```
1. MoSCoW Feature Table
| Feature | Category | Rationale | Effort |
|---|---|---|---|
| Connect to Jira API and pull closed tickets | Must Have | Core data source — without this, no report | L |
| Connect to GitHub API and pull merged PRs | Must Have | Second core data source | L |
| Generate weekly report as markdown/email | Must Have | Core output — the product's reason to exist | M |
| User authentication (email/password) | Must Have | Required to save connections and reports | M |
| Report scheduling (auto-send every Friday) | Should Have | Key convenience feature; manual trigger works for MVP | M |
| Customizable report template | Should Have | Improves adoption but default template works for MVP | L |
| Slack notification when report is ready | Could Have | Nice-to-have; email is sufficient for MVP | S |
| Multi-team support | Won't Have | Adds complexity; single team is enough to validate | — |
| Analytics dashboard | Won't Have | Not needed to validate core hypothesis | — |

2. MVP Definition Statement
The MVP is a web app that connects to one Jira workspace and one GitHub organization, pulls the previous week's closed tickets and merged PRs, and generates a formatted weekly status report that the engineering manager can review and send. The MVP does NOT support multiple teams, custom templates, or automated scheduling — the manager triggers report generation manually. Success means an engineering manager can go from zero to a shareable report in under 5 minutes.

3. Success Metrics
- Metric: Time to first report | Target: < 5 minutes from signup to generated report | Measurement: Session recording
- Metric: Weekly active usage | Target: ≥ 70% of signed-up managers generate a report in week 2 | Measurement: Event tracking
- Metric: Report send rate | Target: ≥ 50% of generated reports are forwarded to stakeholders | Measurement: Email/copy tracking

4. Scope Risk Flags
- Risk: Jira API rate limits slow down data fetching → Mitigation: Cache data after first fetch; show loading state
- Risk: GitHub and Jira data models don't map cleanly to a readable report → Mitigation: Build a manual override field in the report editor
```
