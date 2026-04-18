# Form Design Specification Template

> Fill in all fields before activating the `form-design-specification` skill.

---

## Form Info

**Form Name:** `{{e.g. User Registration, Checkout, Contact Us}}`

**Purpose:** {{what the form does}}

**Route / Page:** `{{e.g. /register, /checkout/shipping}}`

---

## Fields

| Field | Type | Label | Required | Validation | Placeholder |
|-------|------|-------|----------|------------|-------------|
| `{{name}}` | `text` | `{{e.g. Full Name}}` | yes | {{e.g. min 2 chars}} | `{{e.g. John Doe}}` |
| `{{email}}` | `email` | `{{e.g. Email Address}}` | yes | {{valid email format}} | `{{e.g. you@example.com}}` |
| `{{password}}` | `password` | `{{e.g. Password}}` | yes | {{min 8 chars, 1 uppercase}} | — |
| `{{field}}` | `{{type}}` | `{{label}}` | {{yes/no}} | `{{rules}}` | `{{placeholder}}` |

**Field types available:** text, email, password, number, tel, url, textarea, select, checkbox, radio, date, file

---

## Layout

**Columns:** {{e.g. single column, 2-column grid for name fields}}

**Field order:** {{list fields in display order}}

**Submit button:** `{{e.g. "Create Account", "Continue"}}` — position: {{bottom / sticky footer}}

---

## Validation UX

| Trigger | Behavior |
|---------|----------|
| On submit | {{e.g. show all errors at once}} |
| On blur | {{e.g. validate individual field}} |
| On change | {{e.g. real-time for password strength}} |

**Error display:** {{e.g. below field in red, inline icon}}

**Success state:** {{e.g. green checkmark on valid field}}

---

## Accessibility

- All fields have associated `<label>`
- Error messages linked via `aria-describedby`
- Required fields marked with `aria-required="true"`
- Tab order follows visual order

---

## Tech Stack

**Framework:** {{e.g. React + React Hook Form + Zod, Vue 3 + VeeValidate}}
