# Example Output: hypothesis-validation

## Scenario: Willingness to Pay — B2B SaaS

> Output yang dihasilkan ketika diberikan input dari `input.md`

```
1. Hypothesis Statement
"If we show engineering managers a landing page describing automated weekly status reports at $25/month and ask them to enter their credit card, then at least 5% of visitors will complete the payment flow, because engineering managers experience enough pain from manual reporting to pay $25/month to eliminate it."

2. Success Metric
Primary: Metric: Credit card entry rate | Success threshold: ≥ 5% of unique visitors | Failure threshold: < 2% | Measurement method: Stripe payment intent creation rate (charge $0 or $1 to validate card, refund immediately)

Secondary: Email capture rate on "notify me when it launches" CTA — target ≥ 20% as a softer demand signal

3. Test Method
Method: Landing page with payment intent (smoke test)

Steps:
1. Build a single-page landing page (use Carrd or Webflow, 4 hours max) with:
   - Headline: "Your weekly engineering status report, written automatically"
   - 3 bullet points describing the core value
   - Pricing: $25/month
   - CTA: "Start free trial" → Stripe payment form (charge $1, refund immediately)
2. Set up Stripe in test mode, then switch to live for the experiment
3. Run $200 LinkedIn ad campaign targeting "Engineering Manager" job title at companies with 10–200 employees
4. Run for 7 days or until 200 unique visitors, whichever comes first
5. Track: unique visitors, CTA clicks, payment form opens, payment completions

Required tools: Carrd ($19/month), Stripe (free), LinkedIn Campaign Manager ($200 budget)
Minimum sample: 200 unique visitors for meaningful signal

4. Timeline
- Preparation: 2 days (build landing page, set up Stripe, configure LinkedIn campaign)
- Execution: 7 days (run ads, monitor daily)
- Analysis: 1 day (calculate conversion rates, review drop-off points)
- Total: 10 days

5. Expected Outcome
Expected conversion rate: 3–8% (based on B2B SaaS landing page benchmarks)
Expected qualitative signal: Users who don't convert will still leave their email if the pain is real
Confidence: Medium — willingness to pay is hard to predict without prior customer conversations

6. Pivot Triggers
Persevere if: ≥ 5% of visitors complete payment intent (≥ 10 out of 200 visitors)
Pivot if: < 2% conversion after 200 visitors (< 4 completions)
Investigate further if: 2–5% conversion — run 5 interviews with visitors who clicked CTA but didn't complete payment

Pivot options if failing:
- Lower price to $10/month and retest
- Change target user to "VP of Engineering" (higher budget authority)
- Change value prop to "team performance dashboard" instead of "status reports"
```
