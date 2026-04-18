# Example Output: market-sizing

## Scenario: B2B SaaS — Engineering Status Reports (US Market)

> Output yang dihasilkan ketika diberikan input dari `input.md`

```
1. TAM (Top-Down)
- Total software companies in the US: ~500,000 (Source: US Census Bureau, NAICS code 5112)
- Average engineering managers per company: 2 (assumption: companies with 10–500 employees)
- Total potential users: 1,000,000 engineering managers
- Annual revenue per user: $25 × 12 = $300/year
- TAM = 1,000,000 × $300 = $300M/year

2. SAM (Bottom-Up)
Filters applied:
- Companies using Jira AND GitHub: ~40% of software companies → 200,000 companies
- Companies with 10–500 employees (target segment): ~80% of filtered set → 160,000 companies
- Engineering managers who have a weekly reporting requirement: ~60% → 192,000 managers
- Willingness to pay $25/month for automation: ~30% → 57,600 managers
- SAM = 57,600 × $300 = $17.3M/year

3. SOM (3-Year Projection)
| Year | Market Share | Customers | ARR |
|---|---|---|---|
| Year 1 | 0.1% of SAM | 58 customers | $17,400 |
| Year 2 | 0.5% of SAM | 288 customers | $86,400 |
| Year 3 | 1.5% of SAM | 864 customers | $259,200 |

4. Assumptions & Data Sources
- US software companies: 500,000 (Medium confidence — verify with US Census Bureau NAICS 5112)
- Jira + GitHub adoption rate: 40% (Low confidence — verify with Atlassian/GitHub market reports)
- Willingness to pay $25/month: 30% (Low confidence — validate with customer interviews)
```
