# Example Output: sprint-planning

**Expected Output Shape:**
```
1. Sprint Goal
Deliver a complete user account management experience — including profile editing, password reset, and secure auth — so that users can self-manage their accounts without support intervention.

2. Task Breakdown
| # | Item | Type | Points | Priority | Assignee | Notes |
|---|------|------|--------|----------|----------|-------|
| 1 | User profile page | Feature | 5 | P1 | Frontend | Includes avatar upload |
| 2 | Password reset flow | Feature | 8 | P1 | Backend | Requires email service |
| 3 | Fix login flicker on mobile | Bug | 2 | P1 | Frontend | CSS/hydration issue |
| 4 | Rate limiting on auth endpoints | Tech Debt | 3 | P2 | Backend | Use express-rate-limit |
| 5 | Refactor user service | Tech Debt | 5 | P2 | Backend | No behavior change |
| 6 | Email notification for invite | Feature | 5 | P2 | Backend | Depends on email service (item 2) |
| 7 | Spike: WebSocket vs SSE | Spike | 3 | P3 | Any | Time-boxed to 3 hours |

3. Capacity Check
Total selected: 31 points
Team velocity: 36 points
Buffer (10%): 3.6 points
Effective capacity: 32.4 points
Verdict: On-target. Item 7 (spike, 3 pts) is P3 — defer if item 2 or 5 runs over.

4. Dependencies
Internal: Item 6 (email notification) depends on Item 2 (email service setup) — sequence accordingly.
External: Password reset (Item 2) requires SMTP/SendGrid credentials from DevOps — confirm before sprint start.

5. Definition of Done
- Code reviewed by at least one other engineer
- Unit tests written for all new business logic
- QA tested in staging environment
- Password reset flow tested end-to-end with real email delivery
- No P1 bugs introduced
- Product owner sign-off on profile page UI
```


**Expected Output Shape:**
```
1. Sprint Goal
Deliver a reliable data import and export experience with validation, error reporting, and pagination — so that users can confidently upload and browse large datasets.

2. Task Breakdown
| # | Item | Type | Points | Priority | Assignee | Notes |
|---|------|------|--------|----------|----------|-------|
| 1 | CSV import endpoint | Feature | 5 | P1 | Backend | Max 10MB file size |
| 2 | Data validation pipeline | Feature | 5 | P1 | Backend | Depends on Item 1 |
| 3 | Fix export 500 on empty dataset | Bug | 1 | P1 | Backend | Quick fix |
| 4 | Pagination for data listing | Feature | 3 | P2 | Backend | Cursor-based |
| 5 | Integration tests for import | Tech Debt | 3 | P2 | QA/Backend | Depends on Items 1, 2 |
| 6 | Optimize slow search query | Tech Debt | 3 | P3 | Backend | Add index + query rewrite |

3. Capacity Check
Total selected: 20 points
Team velocity: 20 points
Buffer (10%): 2 points
Effective capacity: 18 points
Verdict: Slightly over-committed. Defer Item 6 (3 pts, P3) if Items 1–2 take longer than estimated.

4. Dependencies
Internal: Item 2 depends on Item 1; Item 5 depends on Items 1 and 2 — must be sequenced.
External: None identified.

5. Definition of Done
- CSV import handles files up to 10MB without timeout
- Validation errors returned in structured JSON format
- All new endpoints have integration tests
- QA verified in staging with real CSV files
- Export bug fix verified with empty dataset test case
```
