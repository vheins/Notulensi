# Example Input: acceptance-criteria-writing

### Example 1: React + Node.js — Password Reset Flow
**Input:**
- `{{user_story}}`: "As a registered user, I want to reset my password via email, so that I can regain access to my account if I forget my password."
- `{{tech_stack}}`: "React + Node.js + PostgreSQL + SendGrid"
- `{{context}}`: "Reset tokens expire after 1 hour. Users can only have one active reset token at a time. Passwords must be at least 8 characters with one uppercase letter and one number."


### Example 2: Django + Vue.js — File Upload Feature
**Input:**
- `{{user_story}}`: "As a project member, I want to upload files to a project workspace, so that I can share documents with my team."
- `{{tech_stack}}`: "Vue.js + Django + PostgreSQL + AWS S3"
- `{{context}}`: "Supported file types: PDF, DOCX, XLSX, PNG, JPG. Max file size: 25MB. Files are stored in S3. Virus scanning is not in scope for this story."
