# Dashboard Layout Design Specification Template

> Fill in all fields before activating the `dashboard-layout-design` skill.

---

## Dashboard Info

**Dashboard Name:** `{{e.g. Admin Dashboard, Analytics Overview, User Home}}`

**User Role:** {{e.g. admin, end user, manager}}

**Primary Goal:** {{what the user needs to accomplish on this dashboard}}

---

## Layout Structure

**Grid:** {{e.g. 12-column, 3-column sidebar + main, full-width}}

**Breakpoints:**
| Breakpoint | Layout |
|------------|--------|
| Mobile (<768px) | {{e.g. single column, stacked}} |
| Tablet (768–1024px) | {{e.g. 2 columns}} |
| Desktop (>1024px) | {{e.g. sidebar + 3-column grid}} |

---

## Sections / Widgets

| Section | Position | Size | Content |
|---------|----------|------|---------|
| {{e.g. KPI Cards}} | {{top row}} | {{full width}} | {{e.g. revenue, users, orders, conversion}} |
| {{e.g. Revenue Chart}} | {{left, 2/3 width}} | {{large}} | {{e.g. line chart, last 30 days}} |
| {{e.g. Recent Orders}} | {{right, 1/3 width}} | {{medium}} | {{e.g. last 10 orders table}} |
| {{e.g. Top Products}} | {{bottom left}} | {{medium}} | {{e.g. bar chart}} |
| `{{section}}` | `{{position}}` | `{{size}}` | `{{content}}` |

---

## KPI Metrics (if applicable)

| Metric | Format | Trend | Color |
|--------|--------|-------|-------|
| {{e.g. Total Revenue}} | `${{value}}` | {{up/down arrow}} | {{green/red}} |
| {{e.g. Active Users}} | `{{value}}` | {{sparkline}} | {{blue}} |
| `{{metric}}` | `{{format}}` | `{{trend}}` | `{{color}}` |

---

## Navigation

**Sidebar:** {{yes/no — items: Dashboard, Users, Orders, Settings}}

**Top bar:** {{yes/no — items: search, notifications, user avatar}}

**Breadcrumbs:** {{yes/no}}

---

## Tech Stack

**Framework:** {{e.g. React + Tailwind, Vue 3 + shadcn/ui, Next.js}}

**Chart library:** {{e.g. Recharts, Chart.js, ApexCharts, none}}

**Component library:** {{e.g. shadcn/ui, Ant Design, Material UI, custom}}
