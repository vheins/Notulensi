# Component Inventory Specification Template

> Fill in all fields before activating the `component-inventory-generation` skill.

---

## Project Info

**Project:** `{{project-name}}`

**Tech Stack:** {{e.g. React + TypeScript + Tailwind, Vue 3 + shadcn/ui}}

**Design System:** {{e.g. custom, shadcn/ui, Ant Design, Material UI, none}}

---

## Pages / Screens to Audit

| Page | Route | Description |
|------|-------|-------------|
| `{{e.g. Home}}` | `/` | {{description}} |
| `{{e.g. Product List}}` | `/products` | {{description}} |
| `{{e.g. Checkout}}` | `/checkout` | {{description}} |
| `{{page}}` | `{{route}}` | `{{description}}` |

---

## Component Categories

| Category | Examples |
|----------|---------|
| **Atoms** | Button, Input, Badge, Avatar, Icon |
| **Molecules** | SearchBar, FormField, ProductCard, AlertBanner |
| **Organisms** | Header, Sidebar, ProductGrid, CheckoutForm |
| **Templates** | PageLayout, DashboardLayout, AuthLayout |
| **Pages** | HomePage, ProductPage, CheckoutPage |

---

## Inventory Output Format

For each component, capture:

| Field | Description |
|-------|-------------|
| Name | `{{ComponentName}}` |
| Category | atom / molecule / organism / template |
| Location | `{{src/components/...}}` |
| Props | key props and types |
| States | default, hover, active, disabled, loading, error |
| Used in | list of pages/components |
| Reusable? | yes / no / needs refactor |

---

## Goals

| Goal | Priority |
|------|----------|
| Identify duplicate components | {{high/medium/low}} |
| Find inconsistent patterns | {{high/medium/low}} |
| Candidates for design system extraction | {{high/medium/low}} |
| Accessibility gaps | {{high/medium/low}} |
