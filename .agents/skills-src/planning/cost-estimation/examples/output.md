# Example Output: cost-estimation

**Expected Output Shape:**
```
1. Task Breakdown with Hours
| Feature | Task | Role | Low | High | Mid | Complexity | Notes |
|---------|------|------|-----|------|-----|------------|-------|
| Auth | Email/password auth | Senior | 8 | 12 | 10 | Medium | Includes JWT + refresh tokens |
| Auth | Google OAuth | Senior | 4 | 8 | 6 | Medium | Using NextAuth.js |
| Auth | Auth UI (login/register) | Mid Frontend | 6 | 10 | 8 | Simple | |
| Product Listing | Product API | Senior | 6 | 10 | 8 | Simple | Pagination included |
| Product Listing | Product listing UI | Mid Frontend | 8 | 14 | 11 | Medium | Filters + search |
| Cart | Cart state management | Mid Frontend | 6 | 10 | 8 | Medium | Persisted in localStorage |
| Checkout | Stripe integration | Senior | 10 | 16 | 13 | Complex | Webhooks + error handling |
| Checkout | Checkout UI | Mid Frontend | 8 | 12 | 10 | Medium | |
| Order History | Order API + UI | Senior + Mid | 8 | 14 | 11 | Medium | |
| Admin Dashboard | Admin CRUD + UI | Senior + Mid | 16 | 24 | 20 | Complex | Role-based access |
| QA | Test planning + execution | QA | 20 | 30 | 25 | Medium | Manual + automated |

2. Cost per Task
| Feature | Task | Hours | Rate | Cost |
|---------|------|-------|------|------|
| Auth | Email/password auth | 10 | $130 | $1,300 |
| Auth | Google OAuth | 6 | $130 | $780 |
| Auth | Auth UI | 8 | $85 | $680 |
| Checkout | Stripe integration | 13 | $130 | $1,690 |
| Admin Dashboard | Admin CRUD + UI | 20 | $130/$85 | $2,200 |
| QA | Test execution | 25 | $65 | $1,625 |
[... all tasks listed]

3. Total Cost Estimate
| Feature | Subtotal |
|---------|---------|
| Authentication | $2,760 |
| Product Listing | $1,975 |
| Cart | $680 |
| Checkout | $2,540 |
| Order History | $1,375 |
| Admin Dashboard | $2,200 |
| QA | $1,625 |
| Grand Total | $13,155 |
| Contingency (20%) | $2,631 |
| Final Estimate | $15,786 |

4. Timeline Estimate
Total person-hours: ~130 hours
Calendar duration: ~4 weeks (3 people × 6 hrs/day = 18 hrs/day productive capacity)
Critical path: Auth → Cart → Checkout → QA (cannot parallelize checkout without auth)
Parallel opportunities: Product listing and auth can be developed simultaneously in week 1–2

5. Assumptions and Exclusions
Assumptions: Design mockups provided before development; Stripe account already set up; AWS infrastructure provisioned separately.
Exclusions: Infrastructure setup ($500–1,500 estimated separately), post-launch support, content population.
Estimate validity: 30 days from date of issue.
Change order policy: Any scope change > 4 hours requires a written change order before work begins.
```


**Expected Output Shape:**
```
1. Task Breakdown with Hours
| Feature | Task | Role | Low | High | Mid | Complexity | Notes |
|---------|------|------|-----|------|-----|------------|-------|
| Employee Directory | Django models + API | Senior | 8 | 12 | 10 | Simple | |
| Employee Directory | Search + filter UI | Mid | 10 | 16 | 13 | Medium | Elasticsearch optional |
| Leave Request | Workflow engine | Senior | 16 | 24 | 20 | Complex | State machine required |
| Manager Approval | Approval API + notifications | Senior | 8 | 14 | 11 | Medium | Email notifications |
| HR Dashboard | Reporting queries + UI | Mid | 12 | 20 | 16 | Complex | Chart.js or similar |
| SSO | Azure AD SAML integration | Senior | 10 | 18 | 14 | Complex | Enterprise SSO complexity |

3. Total Cost Estimate
| Feature | Subtotal |
|---------|---------|
| Employee Directory | $2,800 |
| Leave Request Workflow | $3,000 |
| Manager Approval | $1,650 |
| HR Dashboard | $1,600 |
| SSO Integration | $2,100 |
| Grand Total | $11,150 |
| Contingency (20%) | $2,230 |
| Final Estimate | $13,380 |

4. Timeline Estimate
Total person-hours: ~84 hours
Calendar duration: ~3 weeks (2 people × 6 hrs/day = 12 hrs/day)
Critical path: SSO → Employee Directory → Leave Request → Approval (SSO must be first for auth)

5. Assumptions
Assumptions: Azure AD tenant access provided; no legacy data migration required.
Exclusions: User training, deployment to Azure, ongoing maintenance.
Note: SSO estimate has high variance (10–18 hrs) due to enterprise Azure AD configuration complexity.
```
