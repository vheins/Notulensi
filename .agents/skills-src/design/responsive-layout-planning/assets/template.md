# Responsive Layout Planning Specification Template

> Fill in all fields before activating the `responsive-layout-planning` skill.

---

## Page / Component Info

**Name:** `{{e.g. ProductListPage, HeroSection, PricingTable}}`

**Tech Stack:** {{e.g. React + Tailwind CSS, Vue 3 + CSS Grid, HTML + CSS}}

---

## Breakpoints

| Name | Min Width | Max Width | Target Device |
|------|-----------|-----------|---------------|
| xs | 0 | 639px | Mobile portrait |
| sm | 640px | 767px | Mobile landscape |
| md | 768px | 1023px | Tablet |
| lg | 1024px | 1279px | Desktop |
| xl | 1280px | 1535px | Large desktop |
| 2xl | 1536px | — | Wide screen |

---

## Layout per Breakpoint

| Section | Mobile | Tablet | Desktop |
|---------|--------|--------|---------|
| `{{e.g. Hero}}` | {{e.g. stacked, full width}} | {{e.g. 2 columns}} | {{e.g. 2 columns, 60/40 split}} |
| `{{e.g. Product Grid}}` | {{e.g. 1 column}} | {{e.g. 2 columns}} | {{e.g. 4 columns}} |
| `{{e.g. Sidebar}}` | {{e.g. hidden, toggle}} | {{e.g. hidden}} | {{e.g. 280px fixed}} |
| `{{section}}` | `{{mobile}}` | `{{tablet}}` | `{{desktop}}` |

---

## Typography Scaling

| Element | Mobile | Desktop |
|---------|--------|---------|
| H1 | `{{e.g. 28px}}` | `{{e.g. 48px}}` |
| H2 | `{{e.g. 22px}}` | `{{e.g. 36px}}` |
| Body | `{{e.g. 16px}}` | `{{e.g. 16px}}` |

---

## Images

| Image | Mobile | Desktop | Aspect Ratio |
|-------|--------|---------|--------------|
| `{{e.g. Hero}}` | `{{full width, 4:3}}` | `{{50% width, 16:9}}` | {{varies}} |
| `{{e.g. Product}}` | `{{full width}}` | `{{25% width}}` | `1:1` |

---

## Hidden / Shown Elements

| Element | Mobile | Tablet | Desktop |
|---------|--------|--------|---------|
| `{{e.g. Sidebar}}` | hidden | hidden | visible |
| `{{e.g. Mobile menu}}` | visible | visible | hidden |
| `{{e.g. Table columns}}` | {{2 cols}} | {{4 cols}} | {{all cols}} |
