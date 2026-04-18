# Example Output: navigation-structure-design

## Scenario: Default

> Output yang dihasilkan ketika diberikan input dari `input.md`

**1. Route Tree**

```
# Marketing
/                    Home                  Public
/pricing             Pricing               Public
/login               Login                 Public
/signup              Sign Up               Public

# App (Authenticated)
/dashboard           Dashboard             Authenticated
/reports             Reports               Authenticated
/reports/:id         Report Detail         Authenticated
/settings            Settings              Authenticated
/settings/profile    Profile Settings      Authenticated
/settings/billing    Billing               Authenticated

# Admin
/admin               Admin Overview        Admin
/admin/users         User Management       Admin
/admin/team          Team Management       Admin
```

**2. Navigation Component Recommendations**

- Top Navigation Bar: Persistent on all authenticated pages. Contains app logo, primary links (Dashboard, Reports), user avatar menu, and notification bell.
- Sidebar: Collapsible left sidebar on authenticated and admin pages. Collapses to icon-only on narrow viewports.
- Breadcrumbs: Shown on detail pages (`/reports/:id`) and nested settings pages.
- Marketing Header Nav: Minimal top bar on public pages with logo, Pricing link, Login, and Sign Up CTA.

**3. Route Table**

| Route | Page Name | Access Level | Navigation Component | Notes |
|-------|-----------|--------------|----------------------|-------|
| / | Home | Public | Marketing Header Nav | Redirect to /dashboard if authenticated |
| /dashboard | Dashboard | Authenticated | Top Nav + Sidebar | Default landing page after login |
| /reports | Reports | Authenticated | Top Nav + Sidebar | |
| /reports/:id | Report Detail | Authenticated | Top Nav + Sidebar + Breadcrumbs | Lazy-loaded module |
| /settings/billing | Billing | Authenticated | Top Nav + Sidebar | Stripe billing portal integration |
| /admin | Admin Overview | Admin | Top Nav + Sidebar | 403 redirect for non-admin users |
| /admin/users | User Management | Admin | Top Nav + Sidebar | |
