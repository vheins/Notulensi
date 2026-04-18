# Example Output: stakeholder-requirement-extraction

**Expected Output Shape:**
```
1. Functional Requirements
FR-1: The system shall allow customers to log in using their email address and password. [Source: "customers can log in"] Priority: Must Have
FR-2: The system shall display a list of all invoices for the authenticated customer, sorted by date descending. [Source: "see their invoices"] Priority: Must Have
FR-3: The system shall allow customers to download each invoice as a PDF file. [Source: "download PDFs"] Priority: Must Have
FR-4: The system shall display the outstanding balance for each unpaid invoice. [Source: "pay outstanding balances"] Priority: Must Have
FR-5: The system shall allow customers to pay outstanding invoices using a credit card or bank transfer. [Source: "pay outstanding balances"] Priority: Must Have
FR-6: The system shall sync invoice data from QuickBooks Online. [Source: "sync somehow"] Priority: Should Have
FR-7: The system shall send an email notification to customers when a new invoice is available. [Implied by portal purpose] Priority: Should Have

2. Non-Functional Requirements
NFR-1: The portal shall load the invoice list within 2 seconds on a standard broadband connection. [Category: Performance; inferred from "professional" requirement]
NFR-2: The portal shall be fully functional on mobile devices with screen widths from 375px. [Category: Usability; Source: "work on mobile"]
NFR-3: Customer authentication shall use industry-standard password hashing (bcrypt or Argon2) and HTTPS. [Category: Security; inferred from financial data handling]
NFR-4: Payment processing shall comply with PCI DSS requirements. [Category: Security; inferred from payment feature]
NFR-5: The system shall support 500 concurrent users with response times under 2 seconds. [Category: Scalability; Source: "500 customers... expect to grow"]

3. Constraints
- Technical: Must integrate with QuickBooks Online API
- Business: 3-month delivery timeline; ~$25k budget
- Organizational: 2-engineer team; no existing portal infrastructure

4. Assumptions
Assumption-1: Customers will authenticate with email/password (not SSO). Basis: No SSO mentioned; B2B customers typically use email auth. Risk if wrong: SSO integration adds 2–4 weeks.
Assumption-2: Payment processing will use Stripe or similar third-party provider. Basis: PCI compliance is complex to build in-house. Risk if wrong: Custom payment processing significantly increases scope and cost.
Assumption-3: QuickBooks sync is one-way (QuickBooks → portal), not bidirectional. Basis: Portal is read-only for invoices. Risk if wrong: Bidirectional sync doubles integration complexity.

5. Open Questions
Q1: Should customers be able to create their own accounts, or will accounts be created by your team? [Blocking — affects registration flow design]
Q2: Which payment methods must be supported at launch — credit card only, or also ACH/bank transfer? [Blocking — affects payment provider selection]
Q3: How frequently should QuickBooks sync run — real-time, hourly, or daily? [Important — affects architecture]
Q4: Should customers receive email reminders for overdue invoices? [Clarifying — affects notification scope]
Q5: Is there a requirement to support multiple currencies? [Blocking — affects payment and display logic]

Requirements Summary: The system is a customer-facing invoice portal where 500+ B2B customers can log in, view their invoice history, download PDFs, and pay outstanding balances online. It must integrate with QuickBooks Online for invoice data and be mobile-responsive. Payment processing must be PCI-compliant. The portal must be delivered within 3 months on a ~$25k budget by a 2-person team.
```


**Expected Output Shape:**
```
1. Functional Requirements
FR-1: The system shall allow employees to submit leave requests specifying type (annual, sick, personal), start date, end date, and optional notes. [Source: "submit requests"] Priority: Must Have
FR-2: The system shall route leave requests to the employee's direct manager for approval or rejection. [Source: "managers approve or reject"] Priority: Must Have
FR-3: The system shall allow managers to approve or reject requests with an optional comment. [Source: "managers approve or reject"] Priority: Must Have
FR-4: The system shall allow HR staff to view all leave requests across all employees and departments. [Source: "HR can see everything"] Priority: Must Have
FR-5: The system shall track the number of leave days taken and remaining per employee per leave type. [Source: "track how many days"] Priority: Must Have
FR-6: The system shall send Slack notifications to managers when a new leave request is submitted. [Source: "approvals could happen there"] Priority: Should Have
FR-7: The system shall allow managers to approve or reject requests directly from Slack. [Source: "approvals could happen there"] Priority: Should Have

2. Non-Functional Requirements
NFR-1: The system shall authenticate users via Google SSO (OAuth2). [Category: Security; Source: "existing Google SSO"]
NFR-2: Leave balance calculations shall be accurate to the day, accounting for weekends and public holidays. [Category: Reliability; inferred from leave tracking requirement]
NFR-3: The system shall be accessible to all 200 employees simultaneously without performance degradation. [Category: Scalability; inferred from company size]

3. Constraints
- Technical: Must integrate with Slack API and Google OAuth2
- Business: No budget for third-party HR software (custom build required)
- Organizational: 3 HR staff as primary admins; 20 managers as approvers

4. Assumptions
Assumption-1: Leave entitlements (days per year per type) are configured by HR, not calculated automatically from employment contracts. Basis: No mention of contract integration. Risk if wrong: Entitlement calculation adds significant complexity.
Assumption-2: Public holidays are configured per country/region by HR, not pulled from an external calendar API. Basis: Simpler implementation; no external dependency. Risk if wrong: Manual holiday management is error-prone.

5. Open Questions
Q1: Should employees be able to cancel approved leave requests? [Blocking — affects workflow design]
Q2: What leave types need to be supported at launch (annual, sick, parental, unpaid)? [Blocking — affects data model]
Q3: Should the system enforce leave balance limits (prevent requests that exceed remaining balance)? [Blocking — affects validation logic]
Q4: Is there a requirement to export leave data to payroll? [Important — affects reporting scope]

Requirements Summary: The system is an internal leave management tool for 200 employees. Employees submit leave requests, managers approve or reject via the web interface or Slack, and HR has full visibility across all requests. The system tracks leave balances per employee and integrates with Google SSO for authentication and Slack for notifications and approvals.
```
