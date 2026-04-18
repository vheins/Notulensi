# Example Input: stakeholder-requirement-extraction

### Example 1: React + Node.js — Client Brief for Customer Portal
**Input:**
- `{{stakeholder_description}}`: "We need a portal where our customers can log in and see their invoices, download PDFs, and pay outstanding balances. It should look professional and work on mobile. We have about 500 customers right now but expect to grow. We use QuickBooks for accounting and would love if it could sync somehow. We need it done in 3 months."
- `{{context}}`: "B2B services company. Customers are small businesses. Currently invoices are sent by email as PDF attachments. No existing customer portal."
- `{{constraints}}`: "3-month timeline, budget ~$25k, team of 2 engineers, must integrate with QuickBooks Online"


### Example 2: Python + Django — Internal HR Tool
**Input:**
- `{{stakeholder_description}}`: "HR needs a way to manage employee leave requests. Right now everything is done by email and it's a mess. Employees should be able to submit requests, managers approve or reject them, and HR can see everything. We need to track how many days people have taken. We use Slack and it would be great if approvals could happen there."
- `{{context}}`: "Mid-size company, 200 employees, 20 managers, 3 HR staff. Currently no HR system. Using Google Workspace for email."
- `{{constraints}}`: "Must integrate with Slack, must work with existing Google SSO, no budget for third-party HR software"
