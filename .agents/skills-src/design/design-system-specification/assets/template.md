# Design System Specification Template

> Fill in all fields before activating the `design-system-specification` skill.

---

## Design System Info

**Name:** `{{e.g. Acme Design System}}`

**Tech Stack:** {{e.g. React + TypeScript + Tailwind, Vue 3 + CSS Modules}}

**Target:** {{web / mobile / both}}

---

## Foundations

### Color Palette

| Token | Value | Usage |
|-------|-------|-------|
| `color.primary.500` | `{{e.g. #6366F1}}` | Primary actions, links |
| `color.primary.600` | `{{e.g. #4F46E5}}` | Hover state |
| `color.neutral.900` | `{{e.g. #111827}}` | Body text |
| `color.neutral.100` | `{{e.g. #F3F4F6}}` | Backgrounds |
| `color.success` | `{{e.g. #10B981}}` | Success states |
| `color.error` | `{{e.g. #EF4444}}` | Error states |
| `color.warning` | `{{e.g. #F59E0B}}` | Warning states |

### Typography

| Token | Font | Size | Weight | Line Height |
|-------|------|------|--------|-------------|
| `text.heading.xl` | `{{font}}` | `{{e.g. 36px}}` | `700` | `{{e.g. 1.2}}` |
| `text.heading.lg` | `{{font}}` | `{{e.g. 24px}}` | `600` | `{{e.g. 1.3}}` |
| `text.body.md` | `{{font}}` | `{{e.g. 16px}}` | `400` | `{{e.g. 1.5}}` |
| `text.body.sm` | `{{font}}` | `{{e.g. 14px}}` | `400` | `{{e.g. 1.5}}` |
| `text.caption` | `{{font}}` | `{{e.g. 12px}}` | `400` | `{{e.g. 1.4}}` |

### Spacing

**Base unit:** `{{e.g. 4px}}`

| Token | Value |
|-------|-------|
| `space.1` | `4px` |
| `space.2` | `8px` |
| `space.4` | `16px` |
| `space.6` | `24px` |
| `space.8` | `32px` |

### Border Radius

| Token | Value | Usage |
|-------|-------|-------|
| `radius.sm` | `{{e.g. 4px}}` | Inputs, small elements |
| `radius.md` | `{{e.g. 8px}}` | Cards, buttons |
| `radius.lg` | `{{e.g. 16px}}` | Modals, panels |
| `radius.full` | `9999px` | Pills, avatars |

---

## Core Components to Define

| Component | Variants | States |
|-----------|---------|--------|
| Button | primary, secondary, ghost, destructive | default, hover, active, disabled, loading |
| Input | default, error, disabled | default, focus, error, disabled |
| Badge | default, success, warning, error | — |
| Card | default, bordered, elevated | — |
| Modal | sm, md, lg | open, closed |
| {{component}} | {{variants}} | {{states}} |
