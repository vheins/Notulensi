# Hypothesis Validation Template

> Fill in all fields before activating the `hypothesis-validation` skill.

---

## Hypothesis

**Statement:**
> "We believe that **[target user]** will **[take this action / pay this price / experience this outcome]** because **[reason]**."

**Example:**
> "We believe that freelance designers will pay $19/month for automated invoice generation because they currently spend 2+ hours/week on invoicing manually."

---

## Hypothesis Details

| Field | Value |
|-------|-------|
| Target user | `{{e.g. freelance designers with 5+ clients}}` |
| Predicted behavior | `{{e.g. pay $19/mo, use daily, recommend to peers}}` |
| Underlying assumption | `{{e.g. invoicing is painful enough to pay for}}` |
| Risk if wrong | `{{e.g. no paying customers, wasted 3 months}}` |

---

## Validation Method

**Method:** {{customer interview / landing page test / prototype test / A/B test / survey / concierge MVP}}

**Sample size:** {{e.g. 20 interviews, 500 landing page visitors}}

**Timeline:** {{e.g. 2 weeks}}

---

## Success Criteria (define before testing)

| Metric | Threshold | Meaning |
|--------|-----------|---------|
| {{e.g. Interview: "would pay"}} | {{e.g. ≥ 70% say yes}} | {{hypothesis confirmed}} |
| {{e.g. Landing page conversion}} | {{e.g. ≥ 5% email signup}} | {{demand exists}} |
| {{e.g. Prototype task completion}} | {{e.g. ≥ 80% complete}} | {{UX is viable}} |

---

## Results

| Metric | Target | Actual | Pass? |
|--------|--------|--------|-------|
| `{{metric}}` | `{{threshold}}` | `{{result}}` | {{yes/no}} |

**Key learnings:**
- {{learning 1}}
- {{learning 2}}

**Decision:** {{confirmed / invalidated / pivot to: {{new hypothesis}}}}
