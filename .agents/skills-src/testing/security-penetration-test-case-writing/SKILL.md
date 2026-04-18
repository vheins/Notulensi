---
name: security-penetration-test-case-writing
description: >
  Generates security test cases covering OWASP Top 10 vulnerabilities for APIs or web apps.
  Do NOT use for production penetration testing or exploitation.
version: "1.1.0"
time_saved: "Manual: 6-8h | With skill: 20-30m"
license: Proprietary — Personal Use Only
category: testing
complexity: Advanced
tokens: ~4500
tags: [security-testing, owasp, penetration-testing, vulnerability-testing]
author: vheins
---

# Skill: Security Penetration Test Case Writing

## Purpose
Generate automated security tests for OWASP Top 10 vulnerabilities to verify controls and fix flaws before deployment.

## Input
| Variable | Type | Req | Description |
|----------|------|-----|-------------|
| `target_description` | string | Yes | App/API description |
| `tech_stack` | string | Yes | e.g., "Node.js + Express" |
| `owasp_categories` | string | No | Default: all Top 10 |

## Instructions
- **Access Control**: Test horizontal/vertical privilege escalation and IDOR.
- **Injection**: Test SQL, NoSQL, Command, LDAP, and XPath injection in all inputs.
- **Auth**: Verify password policies, account lockout, JWT flaws, and session fixation.
- **Data/Crypto**: Check for sensitive data leakage in logs, weak algorithms, and SSRF.
- **Misconfig**: Scan for verbose errors, default credentials, and missing headers.
- **Components**: Audit dependencies (npm/pip) for known CVEs; report findings.

## Edge Cases
| Case | Strategy |
|------|----------|
| Auth | Create test users in setup to probe protected endpoint boundaries. |
| Rate Limiting | Use bypasses or sequential execution to avoid blocking tests. |
| HTTPS | Skip TLS/header tests if target environment is not production-like. |

## Workflow
```mermaid
flowchart TD
    A([Start: Security Test Writing]) --> B[Parse inputs]
    B --> C{Categories specified?}
    C -- Yes --> D[Focus on specified]
    C -- No --> E[Cover all OWASP Top 10]
    D & E --> F[A01: Access Control]
    D & E --> G[A03: Injection]
    D & E --> H[A07: Auth Failures]
    D & E --> I[A05: Misconfiguration]
    D & E --> J[A10: SSRF]
    D & E --> K[A02: Crypto Failures]
    F & G & H & I & J & K --> L{Auth required?}
    L -- Yes --> M[Create test users in setup]
    L -- No --> N
    M & N --> O{Rate limiting?}
    O -- Yes --> P[Use bypass or sequential execution]
    O -- No --> Q
    P & Q --> R[Write each test case]
    R --> S{HTTPS environment?}
    S -- No --> T[Skip TLS tests]
    S -- Yes --> U[Include crypto tests]
    T & U --> V([Output: Security Test File])
```

## Examples
- [Input Example](@examples/input.md)
- [Output Example](@examples/output.md)

## Quality Gate
- [ ] All requested OWASP categories covered.
- [ ] Injection payloads are realistic.
- [ ] Privilege escalation scenarios included.
- [ ] Auth bypass tested.
- [ ] Secure behavior (not just no-error) verified.

## Changelog
| Version | Date | Description |
|---------|------|-------------|
| 1.1.0 | 2026-03-20 | Restructured: moved examples, references, added compatibility/license |
| 1.0.0 | 2026-03-20 | Initial release |
