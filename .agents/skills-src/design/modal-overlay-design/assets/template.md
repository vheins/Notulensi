# Modal / Overlay Design Specification Template

> Fill in all fields before activating the `modal-overlay-design` skill.

---

## Modal Info

**Name:** `{{e.g. ConfirmDeleteModal, CreateProjectModal, ImagePreviewModal}}`

**Type:** {{dialog / sheet / drawer / tooltip / popover / lightbox}}

**Trigger:** {{e.g. "Delete" button click, keyboard shortcut Cmd+K}}

---

## Content

**Title:** `{{e.g. "Delete Project?"}}`

**Body:** `{{e.g. "This action cannot be undone. All data will be permanently deleted."}}`

**Form fields (if any):**
| Field | Type | Required |
|-------|------|----------|
| `{{field}}` | `{{type}}` | {{yes/no}} |

**Actions:**
| Button | Variant | Action |
|--------|---------|--------|
| `{{e.g. "Cancel"}}` | secondary | close modal |
| `{{e.g. "Delete"}}` | destructive | confirm + close |

---

## Behavior

| Setting | Value |
|---------|-------|
| Close on backdrop click | {{yes/no}} |
| Close on Escape key | yes |
| Focus trap inside modal | yes |
| Scroll lock (body) | yes |
| Animation | {{e.g. fade + scale, slide up from bottom}} |
| Loading state on confirm | {{yes/no}} |

---

## Sizes

| Size | Width | Use Case |
|------|-------|----------|
| sm | `{{e.g. 400px}}` | {{e.g. confirmation dialogs}} |
| md | `{{e.g. 560px}}` | {{e.g. forms}} |
| lg | `{{e.g. 800px}}` | {{e.g. detail views}} |
| full | `100vw × 100vh` | {{e.g. image lightbox}} |

**This modal size:** {{sm / md / lg / full}}

---

## Accessibility

- `role="dialog"` with `aria-modal="true"`
- `aria-labelledby` pointing to modal title
- Focus moves to first focusable element on open
- Focus returns to trigger element on close
- Announce to screen reader on open

---

## Tech Stack

**Framework:** {{e.g. React + Radix UI Dialog, Vue 3 + Headless UI}}
