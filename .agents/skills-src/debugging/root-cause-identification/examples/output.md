# Example Output: root-cause-identification

**Expected Output Shape:**
```
1. Symptom Statement
The checkout endpoint returns HTTP 500 during peak traffic. Logs show HikariCP connection pool exhaustion: "Unable to acquire JDBC Connection."

2. 5-Why Causal Chain
Why do users get 500 errors? → DB connection pool is exhausted.
Why is the pool exhausted? → All 10 connections are held simultaneously during peak load.
Why are connections held so long? → Each checkout request holds a connection for the full 800ms transaction duration.
Why does the transaction take 800ms? → It includes a synchronous call to a third-party payment API inside the DB transaction.
Why is the payment API call inside the transaction? → The original developer assumed the payment call would be fast and included it for atomicity.

3. Root Cause Statement
The root cause is a synchronous external API call inside a database transaction, because this holds DB connections for the full API latency duration, exhausting the pool under load.

4. Fix Recommendation
Move the payment API call outside the DB transaction. Use a two-phase approach: reserve inventory in DB, call payment API, then confirm or rollback.

5. Recurrence Prevention
Add a metric alert when connection pool utilization exceeds 80% for more than 30 seconds.
```


**Expected Output Shape:**
```
1. Symptom Statement
Users are logged out unexpectedly. Redis session keys expire before the configured 24-hour TTL.

2. 5-Why Causal Chain
Why are users logged out? → Session keys expire early.
Why do keys expire early? → TTL is set to a shorter value than 24 hours on some instances.
Why is TTL shorter on some instances? → The new session middleware reads TTL from an env var that defaults to minutes, not hours.
Why does the default differ? → The env var name changed in the deployment but the default unit was not updated.
Why was the unit not caught? → No integration test validates the actual TTL value set in Redis.

3. Root Cause Statement
The root cause is an undocumented unit change in the TTL environment variable, because the new middleware interprets the value as minutes while the old one used hours, and no test validated the resulting Redis TTL.

4. Fix Recommendation
Standardize TTL configuration to always use seconds. Add explicit unit documentation in the env var name (e.g., SESSION_TTL_SECONDS). Update the middleware to parse and validate the value on startup.

5. Recurrence Prevention
Add a startup validation test that reads the session TTL from Redis after setting it and asserts it matches the configured value.
```
