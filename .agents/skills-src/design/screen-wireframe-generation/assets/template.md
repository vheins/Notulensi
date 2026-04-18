# Screen Wireframe Specification Template

> Fill in all fields before activating the `screen-wireframe-generation` skill.

---

## Screen Info

**Screen Name:** `{{e.g. Product Detail Page, User Settings, Onboarding Step 2}}`

**Device:** {{desktop / mobile / tablet}}

**Dimensions:** {{e.g. 1440×900 (desktop), 375×812 (mobile)}}

**Purpose:** {{what the user does on this screen}}

---

## Layout Zones

```
+------------------------------------------+
|  HEADER / NAV                            |
+------------------------------------------+
|  HERO / PAGE TITLE                       |
+------------------+-----------------------+
|  MAIN CONTENT    |  SIDEBAR (optional)   |
|                  |                       |
|                  |                       |
+------------------+-----------------------+
|  FOOTER                                  |
+------------------------------------------+
```

*(Describe or sketch the actual layout for this screen)*

---

## Content Blocks

| Block | Position | Content | Priority |
|-------|----------|---------|----------|
| `{{e.g. Product Image}}` | top-left | {{e.g. main image + thumbnails}} | high |
| `{{e.g. Product Info}}` | top-right | {{e.g. name, price, rating, CTA}} | high |
| `{{e.g. Description}}` | below fold | {{e.g. tabs: description, specs, reviews}} | medium |
| `{{block}}` | `{{position}}` | `{{content}}` | `{{priority}}` |

---

## Interactive Elements

| Element | Type | Action |
|---------|------|--------|
| `{{e.g. Add to Cart}}` | button (primary) | {{add item, show confirmation}} |
| `{{e.g. Quantity}}` | number input | {{update quantity}} |
| `{{e.g. Image thumbnails}}` | clickable images | {{swap main image}} |

---

## States to Wireframe

- [ ] Default / loaded
- [ ] Loading skeleton
- [ ] Empty state
- [ ] Error state
- [ ] {{custom state}}

---

## Annotations

- {{e.g. "Price shows original + discounted if on sale"}}
- {{e.g. "CTA is sticky on mobile"}}
- {{e.g. "Reviews section loads lazily"}}
