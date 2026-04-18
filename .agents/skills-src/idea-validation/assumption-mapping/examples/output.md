# Example Output: assumption-mapping

## Scenario: B2B SaaS — Engineering Status Reports

> Output yang dihasilkan ketika diberikan input dari `input.md`

```
1. User Assumptions
- Assumption: Engineering managers spend more than 1 hour per week creating status reports
  Risk: High — if they spend < 30 minutes, the pain isn't strong enough to pay $25/month
  Validation: Interview 10 engineering managers; ask them to walk through their last report creation process and time it

- Assumption: Engineering managers have decision-making authority to purchase a $25/month tool without budget approval
  Risk: High — if they need procurement approval, sales cycle becomes 3–6 months
  Validation: Ask 5 engineering managers directly: "Could you expense a $25/month tool without approval?"

- Assumption: Engineering managers are dissatisfied with their current reporting process
  Risk: Medium — some managers may have already solved this with Notion templates
  Validation: Ask "How satisfied are you with your current status reporting process?" in 10 interviews; target < 6/10 average

2. Market Assumptions
- Assumption: At least 30% of engineering managers use both Jira and GitHub (required for the integration to work)
  Risk: High — if adoption is lower, the addressable market shrinks significantly
  Validation: Survey 50 engineering managers on LinkedIn about their tool stack

- Assumption: No well-funded competitor will launch a similar product in the next 12 months
  Risk: Medium — Jellyfish or LinearB could add this feature
  Validation: Monitor competitor product roadmaps and job postings for "reporting" features quarterly

3. Technical Assumptions
- Assumption: Jira's REST API provides sufficient data to generate a meaningful narrative report (not just raw ticket counts)
  Risk: High — if the API only returns structured data without context, the report will be low quality
  Validation: Build a 4-hour spike: connect to a real Jira workspace and attempt to generate a sample report

- Assumption: GitHub's API rate limits (5,000 requests/hour) are sufficient for weekly batch processing
  Risk: Low — weekly batch processing is well within rate limits
  Validation: Calculate maximum API calls needed for a 50-engineer team; compare to rate limits

4. Business Model Assumptions
- Assumption: Engineering managers will pay $25/month for a tool that saves them 1–2 hours per week
  Risk: High — willingness to pay is the most critical unknown
  Validation: Create a landing page with pricing; measure conversion rate from "interested" to "enter credit card"

- Assumption: Monthly churn will be below 5% once users see the first report
  Risk: Medium — if the first report is low quality, users will cancel immediately
  Validation: Offer 3 free reports before charging; measure how many users who see 3 reports convert to paid

5. Assumption Priority Matrix
| Priority | Assumption | Category | Risk | Why Critical | Validation |
|---|---|---|---|---|---|
| 1 | Managers will pay $25/month | Business Model | High | No revenue = no business | Landing page + waitlist |
| 2 | Managers spend 1+ hour on reports | User | High | No pain = no product | 10 user interviews |
| 3 | Jira API provides narrative-quality data | Technical | High | Bad data = bad reports | 4-hour technical spike |
| 4 | Managers can expense $25 without approval | User | High | Long sales cycle kills bootstrapped product | Direct question in interviews |
| 5 | 30% of managers use Jira + GitHub | Market | High | Small market = not worth building | LinkedIn survey |
```
