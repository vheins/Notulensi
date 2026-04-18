# Accessibility Test Case Template

> Fill in all fields before activating the `accessibility-test-case-writing` skill.

---

## Component / Page to Test

**Name:** `{{e.g. LoginForm, ProductCard, NavigationMenu}}`

**URL / Route:** `{{e.g. /login, /products/:id}}`

**Tech Stack:** {{e.g. React + TypeScript, Vue 3, HTML/CSS}}

---

## WCAG Compliance Target

**Level:** {{A / AA / AAA}} *(AA is the standard for most products)*

**WCAG Version:** {{2.1 / 2.2}}

---

## Component Description

```
{{describe the component: what it renders, interactive elements, dynamic states}}
```

**Interactive Elements:**
| Element | Type | Expected Behavior |
|---------|------|-------------------|
| `{{e.g. Submit button}}` | `button` | {{e.g. submits form, shows loading state}} |
| `{{e.g. Email input}}` | `input[type=email]` | {{e.g. validates on blur}} |
| `{{e.g. Error message}}` | `div[role=alert]` | {{e.g. appears on validation failure}} |

---

## Accessibility Requirements

| Criterion | WCAG | Required? |
|-----------|------|-----------|
| Keyboard navigation (Tab order) | 2.1.1 | yes |
| Focus visible | 2.4.7 | yes |
| Screen reader labels (aria-label / aria-labelledby) | 1.3.1 | yes |
| Color contrast ≥ 4.5:1 (text) | 1.4.3 | yes |
| Error identification | 3.3.1 | yes |
| No keyboard trap | 2.1.2 | yes |
| Alt text for images | 1.1.1 | {{yes/no}} |
| Form labels | 1.3.1 | {{yes/no}} |

---

## Test Tools

**Automated:** {{e.g. axe-core, jest-axe, Playwright + axe, Lighthouse}}

**Manual:** {{e.g. NVDA + Chrome, VoiceOver + Safari, keyboard-only navigation}}
