# Example Output: component-inventory-generation

## Scenario: Default

> Output yang dihasilkan ketika diberikan input dari `input.md`

**1. Inventory Summary**

The Analytics Dashboard screen contains 18 UI components across three Atomic Design levels. Of these, 9 can be sourced directly from shadcn/ui, 6 need to be built custom, and 3 are shadcn/ui components that require visual or behavioral extension. Atoms account for 7 components, molecules for 7, and organisms for 4.

**2. Component Inventory Table**

| Component Name | Type | Purpose | Props / Inputs | Visual States | Reusability | Source | Notes |
|----------------|------|---------|----------------|---------------|-------------|--------|-------|
| Badge | atom | Displays a status label | label: string, variant: string | default, success, warning, error | shared | design-system | |
| MetricCard | molecule | Shows a KPI value with label and trend | title: string, value: number, trend: number | default, loading, error | shared | custom | Needs sparkline sub-component |
| FilterDropdown | molecule | Filters data by a selected dimension | options: string[], selected: string, onChange: fn | default, open, disabled | shared | extend | Extend shadcn/ui Select |
| ChartPanel | organism | Renders a chart with title and controls | title: string, chartType: string, data: object[] | default, loading, empty, error | page-specific | custom | Wraps Recharts library |
| DashboardHeader | organism | Top bar with title, date range, and actions | title: string, dateRange: object, onExport: fn | default | page-specific | custom | |

**3. Grouping by Atomic Design Level**

Atoms: Badge, Icon, Tooltip, Skeleton, Divider, Button, Avatar

Molecules: MetricCard, FilterDropdown, DateRangePicker, SearchInput, SortControl, TabBar, StatRow

Organisms: ChartPanel, DashboardHeader, MetricsGrid, FilterSidebar

**4. Design System Gap Analysis**

Use from shadcn/ui: Badge, Button, Tooltip, Skeleton, Divider, Avatar, TabBar, SearchInput, DateRangePicker

Build or extend:
- MetricCard — custom layout with sparkline not available in shadcn/ui
- FilterDropdown — extend shadcn/ui Select with multi-select and chip display
- ChartPanel — custom wrapper around Recharts; no chart component in shadcn/ui
- DashboardHeader — page-specific layout combining multiple atoms
- MetricsGrid — responsive grid layout specific to this dashboard
- FilterSidebar — collapsible panel with stacked filter controls
