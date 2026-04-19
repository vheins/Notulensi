# Responsive Layout Planning: Note Detail Screen

## 1. Page Info
- **Name**: Note Detail Screen (Playback, Transcript, Highlights)
- **Tech Stack**: Flutter (`CustomScrollView`, `LayoutBuilder`, `SliverGrid`)

## 2. Breakpoints & Target Devices
| Name | Min Width | Max Width | Target Device |
|------|-----------|-----------|---------------|
| `xs` | 0px | 599px | Mobile Portrait |
| `sm` | 600px | 899px | Mobile Landscape / Mini Tablet |
| `md` | 900px | 1199px | Standard Tablet (iPad) |
| `lg` | 1200px | + | Desktop (Future macOS/Windows) |

## 3. Layout Reflow Strategy
| Section | Mobile (`xs`, `sm`) | Tablet (`md`) | Desktop (`lg`) |
|---------|---------------------|---------------|----------------|
| **App Bar** | Sticky Top, collapses title on scroll. | Fixed Top, full title visible. | Fixed Top with Search Bar integrated. |
| **Highlights Panel** | Horizontal scrolling chips below App Bar. | Fixed Sidebar (Right, 30% width). | Fixed Sidebar (Right, 30% width). |
| **Transcript Body** | Full width (100%), scrolls vertically. | 70% width (Left column). | 70% width (Left column). |
| **Multimedia Gallery**| Horizontal carousel above transcript. | Grid view (2 columns) within the transcript flow. | Grid view (3 columns) below audio player. |
| **Audio Player** | Sticky Bottom sheet overlay. | Embedded at the top of the transcript column. | Embedded at the top of the transcript column. |

## 4. ASCII Grids (Visual Reflow)

**Mobile (`xs`)**
```text
[ < Title             [Share] ]
[ Action 1 ] [ Deadline 1 ] > (Chips)
[ Photo 1 ][ Photo 2 ] > (Carousel)
-------------------------------
Transcript text goes here.
It flows full width downwards.
-------------------------------
[ > Play  ===========  00:00  ] (Sticky)
```

**Tablet (`md`)**
```text
[ < Title                             [Share] ]
+-------------------------+-------------------+
| [ > Play  ===== 00:00 ] | Highlights (30%)  |
|                         |                   |
| Transcript text goes    | - [!] Action 1    |
| here. It flows in this  | - [T] Deadline 1  |
| 70% container column.   | - [T] Deadline 2  |
|                         |                   |
| [Photo 1]   [Photo 2]   |                   |
+-------------------------+-------------------+
```

## 5. Component Transformation Rules
- **Highlights**: Transforms from a `ListView.horizontal` (Mobile) to a `ListView.vertical` inside a `Flexible` container (Tablet/Desktop).
- **Navigation**: The back button remains, but on Desktop, the layout might adopt a Master-Detail (Split-view) if accessed from the Folders page.
- **Audio Player**: Moves from a global `BottomSheet` (Mobile) to an inline `Card` (Tablet) to utilize screen real estate effectively.
