# Example Output: responsive-layout-planning

## Scenario: Default

> Output yang dihasilkan ketika diberikan input dari `input.md`

**1. Breakpoint Summary**

| Breakpoint | Width | Primary Layout Shift |
|------------|-------|----------------------|
| base | 0px+ | Single column; sidebar hidden; activity feed collapsed |
| sm | 640px+ | Single column retained; bottom nav appears |
| md | 768px+ | Sidebar appears as icon-only rail; 2-col main content |
| lg | 1024px | Full sidebar expands with labels; 3-col layout restored |
| xl | 1280px | Right activity panel reappears; max-width container locks |

**2. ASCII Layout Grids**

```
[base — 375px]
+----------------------------------+
|  [☰ Hamburger]   [Logo]  [👤]   |  ← HEADER
+----------------------------------+
|         MAIN CONTENT             |
|  [KPI Card] [KPI Card]           |
|  [Chart — full width]            |
|  [Activity Feed — collapsed ▼]   |
+----------------------------------+
| [🏠] [📊] [🔔] [👤]             |  ← BOTTOM NAV

[lg — 1024px]
+----+---------------------------+--------+
|    |  HEADER (full width)      |        |
+----+---------------------------+--------+
| S  |    MAIN CONTENT           | RIGHT  |
| I  |  [KPI][KPI][KPI]          | PANEL  |
| D  |  [Chart]                  | (20%)  |
| E  |  [Table]                  |        |
|(20%|        (60%)              |        |
+----+---------------------------+--------+
```

**3. CSS Class Hints (Tailwind CSS)**

```
Sidebar:        hidden lg:block lg:w-60
Main content:   col-span-1 lg:col-span-1
Right panel:    hidden xl:block xl:w-72
Bottom nav:     flex lg:hidden fixed bottom-0 w-full
KPI cards row:  grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4
Chart:          w-full h-48 md:h-64 lg:h-80
```

**4. Touch Target & Accessibility Notes**

- Hamburger button: 44×44px ✅ (p-3 on 24px icon = 48px)
- Bottom nav items: 44px height ✅ (py-3 on icon+label)
- Chart tooltips: triggered on touch; ensure 44px touch area on data points ⚠️
- Focus order: sidebar nav items must retain logical DOM order even when visually hidden at mobile
