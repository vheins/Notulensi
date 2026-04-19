# Mobile-First UI Specification: Recording Screen

## 1. Screen Info
- **Screen Name**: Active Recording Capture
- **Platform**: Flutter (Android & iOS)
- **Primary Device**: Mobile Handset

## 2. Thumb-Zone Layout (Safe Area Priority)
```text
+-----------------------+ -> STATUS BAR (SAFE)
| [X]          00:15:42 | -> HARD ZONE (Reach)
+-----------------------+
|                       |
|   (Transcript Area)   | -> STRETCH ZONE (Scroll)
|                       |
|                       |
+-----------------------+
|    (Waveform Area)    | -> SAFE ZONE (Comfortable)
|                       |
|  [Star] [Stop] [Pic]  | -> SAFE ZONE (Primary Target)
+-----------------------+ -> HOME INDICATOR (SAFE)
```

## 3. Touch Targets & Accessibility
| Action | Min Target | Recommended | Zone | Risk |
|--------|------------|-------------|------|------|
| **Stop Recording** | 48x48 dp | 72x72 dp (FAB) | SAFE | Low |
| **Drop Marker** | 48x48 dp | 56x56 dp | SAFE | Low |
| **Take Photo** | 48x48 dp | 56x56 dp | SAFE | Low |
| **Cancel/Close** | 44x44 dp | 48x48 dp | HARD | High (Intentional to prevent accidental tap) |

## 4. Gestures & Hardware Interrupts
| Type | Target | Action | Conflict Risk |
|------|--------|--------|---------------|
| **Vertical Swipe** | Transcript Area | Scroll through past live text. | Low |
| **Hardware Key** | Volume Up/Down | Drops a visual marker (Bookmark). | Medium (Overrides system volume while active) |
| **Voice Command** | Mic Input | "Stop Recording" triggers stop. | Low (Processed locally via STT stream) |

## 5. Safe Area & Insets
- **Top**: Respect system status bar (dynamic padding via `SafeArea`).
- **Bottom**: Minimum 24dp padding above iOS Home Indicator to prevent swipe conflicts with the FABs.
- **L/R Edges**: 16dp horizontal padding for all text content to prevent edge-distortion on curved screens.

## 6. Platform Conventions & Haptics
- **Haptics (Vibration)**:
  - Medium impact on 'Record/Stop'.
  - Light impact when dropping a 'Marker' (to confirm action without looking).
  - Heavy double-impact on errors (e.g., Mic permission revoked mid-stream).
- **Screen Wake Lock**: Keep screen awake (`WakelockPlus` package) while this route is active.
