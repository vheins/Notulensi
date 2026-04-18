# Example Output: mobile-first-ui-specification

## Scenario: Default

> Output yang dihasilkan ketika diberikan input dari `input.md`

**1. Thumb-Zone Analysis (ASCII Diagram)**

```
┌─────────────────────────┐
│ ▓▓▓ Dynamic Island ▓▓▓  │  ← Top safe area inset: 59pt
│  Status Bar (20pt)      │
├─────────────────────────┤
│  H  H  H  H  H  H  H   │  ← HARD zone (top 25%: ~211pt)
│                         │    Product images carousel
│                         │    Share button (⚠ placement risk)
├─────────────────────────┤
│  T  T  T  T  T  T  T   │  ← STRETCH zone (middle 35%: ~295pt)
│                         │    Product title, price
│                         │    Size/color selector
├─────────────────────────┤
│  S  S  S  S  S  S  S   │  ← SAFE zone (bottom 40%: ~338pt)
│                         │    Add to Cart button (primary CTA)
├─────────────────────────┤
│  Bottom Tab Bar (83pt)  │
│ ▓▓▓ Home indicator ▓▓▓ │  ← Bottom safe area inset: 34pt
└─────────────────────────┘
```

**2. Touch Target Audit**

| Action | Component Type | Min Touch Target | Thumb Zone | Placement Risk | Recommendation |
|--------|----------------|------------------|------------|----------------|----------------|
| add to cart | Button (full-width) | 44×44pt | SAFE | NO | OK |
| view product images | Image Carousel | 44×44pt | HARD | YES | Move navigation arrows to STRETCH zone; use swipe gesture as primary |
| share product | Icon Button | 44×44pt | HARD | YES | Move to navigation bar trailing position |
| select size/color | Chip/Selector | 44×44pt | STRETCH | NO | OK |

**3. Gesture Map**

| Gesture | Target Element | Action Triggered | Conflict Risk |
|---------|----------------|------------------|---------------|
| Tap | Add to Cart button | Add item to cart | NO |
| Swipe Left/Right | Product image carousel | Navigate images | YES — conflicts with iOS swipe-back |
| Swipe Up | Content scroll area | Scroll product details | NO |
| Long-press | Product image | Show image save/share action sheet | NO |

**4. Safe Area Inset Spec**

- Top inset: 59pt (Dynamic Island 37pt + status bar 22pt)
- Bottom inset: 34pt (home indicator)
- Content padding: minimum 16pt horizontal padding inside safe area bounds
- Bottom CTA button: must sit above `safeAreaInsets.bottom + 16pt`
