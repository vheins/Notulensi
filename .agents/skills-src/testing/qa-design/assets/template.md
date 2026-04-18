# Test Scenarios: {{feature_name}}

> Skenario pengujian untuk fitur {{feature_name}}.

## Scope & Assumptions
- **Scope:** {{what_is_tested}}
- **Assumptions:** {{prerequisites}}

---

## 1. Positive Testing (Happy Path)

| ID | User Story | Test Case | Pre-condition | Input | Expected Result | Priority |
|----|------------|-----------|---------------|-------|-----------------|----------|
| POS-001 | US-01 | **{{test_title}}** | {{condition}} | {{input}} | {{result}} | High |
| POS-002 | US-01 | **{{test_title}}** | {{condition}} | {{input}} | {{result}} | Medium |

---

## 2. Negative Testing (Validation & Errors)

| ID | User Story | Test Case | Pre-condition | Input | Expected Result | Priority |
|----|------------|-----------|---------------|-------|-----------------|----------|
| NEG-001 | US-01 | **{{test_title}}** | {{condition}} | {{invalid_input}} | {{error_result}} | High |
| NEG-002 | US-01 | **{{test_title}}** | {{condition}} | {{invalid_input}} | {{error_result}} | High |

---

## 3. Monkey Testing (Chaos & Exploratory)

| ID | Focus | Test Case | Pre-condition | Expected Result | Priority |
|----|-------|-----------|---------------|-----------------|----------|
| MON-001 | **{{focus}}** | **{{test_case}}** | {{condition}} | {{result}} | Medium |

---

## 4. Security Testing

| ID | Role | Test Case | Action | Expected Result | Priority |
|----|------|-----------|--------|-----------------|----------|
| SEC-001 | {{role}} | **IDOR: Access other user's resource** | Change ID in URL to another user's ID | 403 Forbidden | High |
| SEC-002 | {{role}} | **AuthZ: Unauthorized role access** | Access admin endpoint with user token | 403 Forbidden | High |
| SEC-003 | — | **Injection: XSS in input field** | Submit `<script>alert(1)</script>` | Input sanitized, no script executed | High |

---

## Coverage Summary

| User Story | Positive | Negative | Monkey | Security | Total |
|------------|----------|----------|--------|----------|-------|
| US-01 | {{count}} | {{count}} | {{count}} | {{count}} | {{total}} |

**Total Scenarios:** {{total_count}}
**Gaps:** {{gaps_or_none}}
