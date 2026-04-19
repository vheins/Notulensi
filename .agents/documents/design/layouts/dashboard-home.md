# Dashboard Layout Design: Home Screen

## 1. Dashboard Info
- **Name**: Home Screen (Dashboard & Global Search)
- **User Role**: Primary User
- **Goal**: Quickly find past meetings, view local productivity insights, and initiate new recordings.
- **Framework**: Flutter (`GetX` for State/Routing, `SliverAppBar`, `GridView`)

## 2. Layout Structure
**Grid Strategy**: Fluid Grid for Note Cards, Staggered Stacks for Metrics.

| Breakpoint | Layout |
|------------|--------|
| Mobile (`xs`) | 1-Column Note List. Vertical stack for Metrics. |
| Tablet (`md`) | 2-Column Note Grid. Horizontal row for Metrics (2x2). |

## 3. Sections & Widgets (Mobile Priority)
| Section | Position | Size | Content / Behavior |
|---------|----------|------|--------------------|
| **Search Bar** | Top (Sliver Header) | 100% Width | Sticky on scroll. Local Isar full-text search. |
| **Insights Ribbon** | Below Search | Horizontal Scroll | Storage Used (MB), Total Notes, Action Items Pending. |
| **Project Folders** | Above Note List | Horizontal Scroll | Folder cards (e.g., "Client A", "Internal"). |
| **Recent Notes** | Main Body | Vertical List | Note Cards (Title, Date, Duration, Tags). |
| **FAB** | Bottom Right | Floating | Giant 'Microphone' button for instant recording. |
| **AdMob Banner** | Bottom Safe Area | 100% Width | 320x50 standard banner ad (Free tier only). |

## 4. Local KPI Metrics (Insight Ribbon)
| Metric | Format | Source | UI Treatment |
|--------|--------|--------|--------------|
| **Pending Tasks** | `12 Open` | Count of `isCompleted == false` ActionItems. | Red badge if > 10. |
| **Storage Saved** | `1.2 GB` | Isar `bytesSavedByTrimming` stat. | Green text, celebratory icon. |
| **Total Notes** | `45` | Count of `MeetingNoteCollection`. | Neutral grey. |

## 5. States & Fallbacks
- **Loading**: Instant local load (No skeleton needed for Isar, <50ms query time).
- **Empty State**: If 0 notes -> Show illustrative vector of a microphone + CTA text: "Tap the mic to record your first private meeting."
- **Search Empty**: Show "No matches found in transcripts or titles."
- **Safe-Box Locked**: Entire screen is replaced with a Biometric Prompt overlay. No data is rendered underneath until unlocked.

## 6. Action Triggers
- **Tap Note Card**: Pushes `NoteDetailRoute`.
- **Long-Press Note Card**: Triggers Multi-select mode (Delete/Move to Folder).
- **Tap FAB**: Requests mic permission -> Opens `RecordingModal`.
