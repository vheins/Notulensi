# Example Output: screen-wireframe-generation

## Scenario: Default

> Output yang dihasilkan ketika diberikan input dari `input.md`

**1. Layout Grid**

```
+----------------------------------------------------------+
|                        HEADER (8%)                        |
|  [Logo]  [Top Nav Links]          [🔔 Bell] [👤 Avatar]  |
+----------+-----------------------------------------------+
|          |                                               |
| SIDEBAR  |              MAIN CONTENT (80%)              |
|  (20%)   |  [KPI Card] [KPI Card] [KPI Card]            |
|          |  +---------------------------------------+   |
| [Nav 1]  |  |         LINE CHART (Velocity)         |   |
| [Nav 2]  |  +---------------------------------------+   |
| [Nav 3]  |  |         DATA TABLE (Open PRs)         |   |
| [Nav 4]  |  +---------------------------------------+   |
|          |                                               |
+----------+-----------------------------------------------+
|                        FOOTER (4%)                        |
|  © 2025 Acme Corp          [Help] [Status] [Docs]        |
+----------------------------------------------------------+
```

**2. Component Placement**

- Top Nav (HEADER, full-width): links to main sections; active state underlined
- Notification Bell (HEADER, top-right): badge shows unread count; click opens dropdown panel
- Avatar Menu (HEADER, top-right): click reveals profile/logout dropdown
- Sidebar Navigation (SIDEBAR, full-height): collapsible; active item highlighted
- KPI Cards ×3 (MAIN CONTENT, top row): display metric + trend arrow; click drills into detail
- Line Chart (MAIN CONTENT, mid): shows 30-day velocity trend; hover reveals tooltip
- Data Table (MAIN CONTENT, bottom): sortable columns; row click opens PR detail panel

**3. Navigation Flow**

- Click sidebar item → full page navigation to respective section
- Click KPI Card → slide-in detail panel (no full navigation)
- Click notification → modal overlay with notification list
- Click avatar → dropdown (stays on current page)

**4. Annotations**

- A1: KPI cards use color-coded trend arrows (green up, red down) — no text labels to save space
- A2: Sidebar collapses to icon-only mode at 1280px to maximize chart area
- A3: Data table defaults to sorting by "Last Updated" descending

**5. Responsive Considerations**

- Mobile (<768px): Sidebar becomes bottom tab bar (max 4 items); KPI cards stack vertically; chart height reduces to 200px
- Tablet (768–1024px): Sidebar collapses to icon-only; KPI cards show 2-per-row grid
