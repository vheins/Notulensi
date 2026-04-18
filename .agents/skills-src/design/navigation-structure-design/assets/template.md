# Navigation Structure Design Specification Template

> Fill in all fields before activating the `navigation-structure-design` skill.

---

## App Info

**App Name:** `{{app-name}}`

**Type:** {{web app / mobile app / both}}

**User Roles:** {{e.g. guest, user, admin}}

---

## Navigation Pattern

**Primary pattern:** {{top navbar / sidebar / bottom tab bar / hamburger menu / breadcrumbs}}

**Secondary pattern:** {{e.g. breadcrumbs, tabs within page, contextual sidebar}}

---

## Navigation Items (per role)

### Guest (unauthenticated)

| Label | Route | Icon | Notes |
|-------|-------|------|-------|
| Home | `/` | home | |
| {{item}} | `{{route}}` | `{{icon}}` | |

### User (authenticated)

| Label | Route | Icon | Badge | Notes |
|-------|-------|------|-------|-------|
| Dashboard | `/dashboard` | grid | — | |
| {{item}} | `{{route}}` | `{{icon}}` | `{{e.g. notification count}}` | |

### Admin

| Label | Route | Icon | Notes |
|-------|-------|------|-------|
| Admin Panel | `/admin` | shield | admin only |
| {{item}} | `{{route}}` | `{{icon}}` | |

---

## Active State

**Indicator:** {{e.g. left border highlight, background fill, underline, bold text}}

**Color:** `{{e.g. primary-500}}`

---

## Mobile Behavior

| Breakpoint | Navigation |
|------------|------------|
| < 768px | {{e.g. hamburger → slide-out drawer}} |
| 768–1024px | {{e.g. collapsed sidebar with icons}} |
| > 1024px | {{e.g. full sidebar with labels}} |

---

## Tech Stack

**Framework:** {{e.g. React + React Router, Next.js App Router, Vue Router}}

**Component:** {{e.g. custom, shadcn/ui NavigationMenu, Ant Design Menu}}
