# Design System Specification: Notulensi

## 1. Design System Info
- **Name**: Notulensi Core UI
- **Tech Stack**: Flutter (`GetX` for State, `ThemeData`, `ThemeExtension`)
- **Target**: Mobile (iOS & Android)
- **Style Direction**: Clean, Minimalist, Native-feel (Material 3 base), Privacy-focused (darker hues for Safe-Box mode).
- **Dark Mode**: Yes (Requires explicit mapping).

## 2. Foundations: Color Palette
| Token | Light Mode Value | Dark Mode Value | Usage |
|-------|------------------|-----------------|-------|
| `color.primary` | `#0A84FF` (Blue) | `#5E5CE6` (Indigo) | Primary FABs, Active states, Links. |
| `color.secondary` | `#30D158` (Green) | `#32D74B` (Green) | Success actions, Completed items. |
| `color.background`| `#F2F2F7` (Off-white)| `#000000` (Pure Black)| Main app background. |
| `color.surface` | `#FFFFFF` (White) | `#1C1C1E` (Dark Grey) | Cards, Modals, Bottom Sheets. |
| `color.text.high` | `#000000` (Black) | `#FFFFFF` (White) | Headings, Primary body text. |
| `color.text.low` | `#8E8E93` (Grey) | `#98989D` (Grey) | Timestamps, Secondary labels. |
| `color.error` | `#FF453A` (Red) | `#FF453A` (Red) | Recording dot, Delete actions. |

## 3. Foundations: Typography
*Base Font: System Default (`Roboto` on Android, `San Francisco` on iOS)*

| Token | Size | Weight | Line Height | Usage |
|-------|------|--------|-------------|-------|
| `text.heading.lg` | `32px` | `w700` | `1.2` | Folder Titles, Empty State Headers. |
| `text.heading.md` | `24px` | `w600` | `1.3` | Note Titles, Modal Headers. |
| `text.body.lg` | `18px` | `w400` | `1.5` | Live Transcript Body. |
| `text.body.md` | `16px` | `w400` | `1.5` | Standard inputs, List items. |
| `text.caption` | `12px` | `w500` | `1.2` | Tag Chips, Timestamps. |

## 4. Foundations: Spacing & Radius
**Base Spacing Unit:** `4dp`
| Token | Value | Usage |
|-------|-------|-------|
| `space.xs` | `4dp` | Between icon and text in chips. |
| `space.sm` | `8dp` | List item gaps. |
| `space.md` | `16dp` | Default horizontal screen padding. |
| `space.lg` | `24dp` | Bottom padding above safe area. |
| `space.xl` | `32dp` | Section breaks. |

**Border Radius:**
| Token | Value | Usage |
|-------|-------|-------|
| `radius.sm` | `8dp` | Input fields, Dialogs. |
| `radius.md` | `12dp` | Note Cards, Folders. |
| `radius.lg` | `24dp` | Bottom Sheet top corners. |
| `radius.full` | `999dp`| FABs, Tag Chips, Play buttons. |

## 5. Shadow & Elevation
| Token | Value (CSS Equivalent) | Usage |
|-------|------------------------|-------|
| `elevation.low` | `0px 2px 4px rgba(0,0,0,0.05)` | Note Cards in list. |
| `elevation.med` | `0px 4px 12px rgba(0,0,0,0.1)` | Sticky bottom bars, Tooltips. |
| `elevation.high`| `0px 8px 24px rgba(0,0,0,0.15)`| FABs, Floating Menus. |

## 6. Core Component Styles
| Component | Variants | States |
|-----------|---------|--------|
| **Button** | Primary (Filled), Ghost (Text) | Default, Pressed, Disabled |
| **Card** | Elevated (List), Outlined (Selected) | Default, Long-press (Select) |
| **Chip** | Action Item, Deadline, Keyword | Default, Filter-Active |
| **Input** | Underlined (Search), Filled (Forms)| Default, Focused, Error |

## 7. Framework Implementation (Flutter Dart)
```dart
// Custom ThemeExtension for Notulensi Colors
class NotulensiColors extends ThemeExtension<NotulensiColors> {
  final Color primary;
  final Color background;
  final Color surface;
  final Color textHigh;
  final Color textLow;
  final Color error;

  const NotulensiColors({
    required this.primary,
    required this.background,
    required this.surface,
    required this.textHigh,
    required this.textLow,
    required this.error,
  });

  // copyWith and lerp implementations omitted for brevity...
}
```
