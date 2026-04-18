# QA Execution Report: {{feature_name}}

**Feature:** {{feature_description}}
**Environment:** {{environment}}
**Executed By:** {{executor}}
**Date:** {{date}}

---

## Execution Summary

| Scenario ID | Title | Type | Result | Notes |
|-------------|-------|------|--------|-------|
| {{scenario_id}} | {{title}} | Automated / Manual | ✅ PASS / ❌ FAIL / ⏭️ SKIP | {{notes}} |

---

## Bug Reports

### BUG-{{scenario_id}}

- **Severity:** Critical / High / Medium / Low
- **Title:** {{bug_title}}
- **Actual Behavior:** {{actual}}
- **Expected Behavior:** {{expected}}
- **Steps to Reproduce:**
  1. {{step_1}}
  2. {{step_2}}
- **Evidence:** {{error_message_or_log}}
- **Suggested Fix:** {{optional_fix}}

---

## Regression Check

Re-run these scenarios after fixing the bugs above:
- {{scenario_id}}: {{reason}}

---

## Final Verdict

**{{PASS / FAIL / BLOCKED}}** — {{summary}}
