# Mobile-First UI Specification Template

> Fill in all fields before activating the `mobile-first-ui-specification` skill.

---

## Screen Info

**Screen Name:** `{{e.g. Product Detail, Home Feed, Profile}}`

**Platform:** {{iOS / Android / both (React Native / Flutter)}}

**Tech Stack:** {{e.g. React Native + Expo, Flutter, Swift, Kotlin}}

---

## Screen Dimensions

| Device | Width | Height |
|--------|-------|--------|
| iPhone SE | 375px | 667px |
| iPhone 14 | 390px | 844px |
| Android (standard) | 360px | 800px |
| Tablet (if needed) | 768px | 1024px |

---

## Layout (Mobile-First)

**Safe areas:** {{handle notch / status bar / home indicator: yes/no}}

**Scroll behavior:** {{e.g. vertical scroll, sticky header, pull-to-refresh}}

**Navigation:** {{e.g. bottom tab bar, stack navigation, drawer}}

---

## Components

| Component | Position | Description |
|-----------|----------|-------------|
| `{{e.g. Header}}` | top | {{e.g. back button + title + action icon}} |
| `{{e.g. Hero Image}}` | below header | {{e.g. full-width, 16:9 ratio}} |
| `{{e.g. Product Info}}` | scrollable | {{e.g. name, price, description}} |
| `{{e.g. CTA Button}}` | sticky bottom | {{e.g. "Add to Cart", full width}} |
| `{{component}}` | `{{position}}` | `{{description}}` |

---

## Touch Interactions

| Element | Interaction | Feedback |
|---------|-------------|----------|
| `{{e.g. Add to Cart}}` | tap | {{e.g. haptic feedback + button press animation}} |
| `{{e.g. Image}}` | pinch-to-zoom | {{e.g. zoom in/out}} |
| `{{e.g. List item}}` | swipe left | {{e.g. reveal delete action}} |

**Minimum touch target:** {{44×44pt (iOS) / 48×48dp (Android)}}

---

## Performance Targets

| Metric | Target |
|--------|--------|
| First render | < {{e.g. 1s}} |
| Image load | lazy, with placeholder |
| List virtualization | {{yes/no — for lists >50 items}} |
