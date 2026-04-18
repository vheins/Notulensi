# Example Output: modal-overlay-design

## Scenario: Default

> Output yang dihasilkan ketika diberikan input dari `input.md`

**1. Trigger Specification**

- Element: `<button>` with `role="menuitem"` inside an action menu; add `aria-haspopup="dialog"` on the trigger
- Interaction: click
- Trigger state when open: button `aria-expanded="true"`; menu closes before dialog opens

**2. Content Structure**

- Header: "Delete [Item Name]?" title (h2, `id="dialog-title"`); close button top-right (×, `aria-label="Close dialog"`)
- Body: "This action cannot be undone. [Item Name] will be permanently deleted." (`id="dialog-description"`)
- Footer: "Cancel" (secondary) and "Delete" (destructive primary)
- Dimensions: width 480px, max-width 90vw, height auto

**3. Dismiss Behavior**

- Close button: top-right ×, activated by Enter and Space
- Backdrop click: yes — closes dialog and cancels action
- Escape key: yes — closes dialog and cancels action
- Programmatic close: after successful delete API response

**4. Animation and Transition Spec**

- Entry: fade in + scale from 0.95 to 1.0, duration 150ms, ease-out
- Exit: fade out + scale from 1.0 to 0.95, duration 100ms, ease-in
- Reduced motion: opacity fade only (no scale transform)

**5. Accessibility Requirements**

- `role="dialog"`, `aria-modal="true"`
- `aria-labelledby="dialog-title"`, `aria-describedby="dialog-description"`
- Focus trap: Tab cycles between Cancel, Delete, and close button only
- Initial focus: "Cancel" button (safe default for destructive dialogs)
- Return focus: restore to Delete trigger button on close

**6. Figma Component Structure**

- Component: DeleteConfirmationDialog / frame: 480×auto
- Variants: Closed, Open, Loading, Error
- Layers: [Backdrop] / [DialogPanel] → [Header] / [Body] / [Footer]
