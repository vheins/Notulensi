# Example Input: postmortem-report-writing

### Example 1: Database Outage Postmortem
**Input:**
- `{{incident_title}}`: "PostgreSQL connection pool exhaustion — 2024-11-14"
- `{{service_name}}`: "Orders API"
- `{{team_name}}`: "Backend Platform"
- `{{impact_description}}`: "All order creation and order status endpoints returned 503 errors. Approximately 12,000 users were unable to place orders. Peak error rate reached 98%. Estimated $47,000 in lost GMV over 34 minutes."
- `{{incident_timeline}}`: "14:22 - Spike in DB connection errors in logs. 14:31 - PagerDuty alert fires for 5xx rate > 10%. 14:33 - On-call engineer paged. 14:41 - Engineer identifies connection pool at max (100/100 connections). 14:45 - Identified long-running analytics query holding connections. 14:48 - Analytics query killed manually. 14:52 - Connection pool drains, error rate drops to 0. 14:56 - Incident resolved, monitoring confirmed stable."


### Example 2: Database Connection Pool Exhaustion — SaaS Platform
**Input:**
- `{{incident_title}}`: "Database connection pool exhaustion causing 503 errors"
- `{{incident_date}}`: "2024-02-20"
- `{{duration}}`: "47 minutes"
- `{{impact}}`: "100% of API requests failed for 47 minutes, affecting 8,200 active users"
- `{{root_cause}}`: "Slow query in reporting module held connections open, exhausting pool of 20 connections during peak traffic"
