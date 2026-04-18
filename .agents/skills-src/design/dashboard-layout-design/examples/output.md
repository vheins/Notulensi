# Example Output: dashboard-layout-design

## Scenario: Default

> Output yang dihasilkan ketika diberikan input dari `input.md`

**1. Widget Grid Layout (ASCII)**

```
┌─────────────────────────────────────────────────────────────────┐
│  FILTER BAR: [Team ▼]  [Sprint ▼]  [Date Range 📅]  [Refresh ↺] │
├──────────────┬──────────────┬──────────────┬────────────────────┤
│   VEL-KPI    │   PR-KPI     │   DEPLOY-KPI │     MTTR-KPI       │
│  (3col×1row) │  (3col×1row) │  (3col×1row) │    (3col×1row)     │
├──────────────┴──────────────┼──────────────┴────────────────────┤
│        VEL-TREND            │           PR-LIST                  │
│        (6col×3row)          │           (6col×3row)              │
├─────────────────────────────┴────────────────────────────────────┤
│                        DEPLOY-HEATMAP                            │
│                        (12col×2row)                              │
├──────────────────────────────┬───────────────────────────────────┤
│         COV-GAUGE            │           MTTR-BAR                │
│         (6col×2row)          │           (6col×2row)             │
└──────────────────────────────┴───────────────────────────────────┘
```

**2. Widget Inventory Table**

| Widget Name | Metric | Visualization | Dimensions | Data Source | Empty State | Loading State |
|-------------|--------|---------------|------------|-------------|-------------|---------------|
| Velocity KPI Card | velocity | KPI Card | 3col × 1row | /api/metrics/velocity | "No sprint data available" | Shimmer block |
| Open PRs KPI Card | open PRs | KPI Card | 3col × 1row | /api/metrics/open-prs | "No open PRs" | Shimmer block |
| Deployment Frequency KPI Card | deployment frequency | KPI Card | 3col × 1row | /api/metrics/deploys | "No deployments recorded" | Shimmer block |
| MTTR KPI Card | MTTR | KPI Card | 3col × 1row | /api/metrics/mttr | "No incidents recorded" | Shimmer block |
| Velocity Trend Line Chart | velocity | Line Chart | 6col × 3row | /api/metrics/velocity/history | "No historical data yet" | Skeleton chart |
| Open PR List Table | open PRs | Table | 6col × 3row | /api/prs/open | "No open pull requests" | Skeleton rows |
| Deployment Frequency Heatmap | deployment frequency | Heatmap | 12col × 2row | /api/metrics/deploys/history | "No deployment history" | Skeleton grid |
| Test Coverage Gauge | test coverage | Gauge / Radial | 6col × 2row | /api/metrics/coverage | "Coverage data unavailable" | Spinner |
| MTTR Bar Chart | MTTR | Bar Chart | 6col × 2row | /api/metrics/mttr/history | "No incident history" | Skeleton chart |

**3. Responsive Behavior**

- Desktop (≥1440px): Full 12-column grid, all widgets visible
- Tablet (768px–1439px): KPI cards 2-per-row, charts stack vertically
- Mobile (<768px): All widgets in single column, filter bar collapsed to icon row
