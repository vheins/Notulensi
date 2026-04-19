# Component Inventory Specification: Notulensi

## 1. Project Info
- **Project**: Notulensi
- **Tech Stack**: Flutter, Bloc/Cubit, Isar.
- **Design System**: Custom (Vanilla CSS-like styling approach).

## 2. Summary
- **Screens Inventoried**: Home Dashboard, Recording Modal, Note Detail, Folder Manager.
- **Total Components**: ~18 identifiable UI components.
- **Methodology**: Atomic Design classification (Atoms, Molecules, Organisms).

## 3. Atomic Grouping
### Atoms (Foundational Elements)
- `PrimaryButton`: Full-width standard action button.
- `IconButton`: Circular button for actions (Mic, Camera, Back).
- `TagChip`: Small rounded container for Action Items / Deadlines.
- `StatusBadge`: Red recording dot or "Unsaved" indicator.
- `TimeDisplay`: Monospace text widget for "00:00:00".

### Molecules (Simple Groupings)
- `NoteCard`: Combines text (Title, Date) and `TagChip`s for the list view.
- `SearchBar`: Text input with a trailing clear icon and search prefix.
- `FolderListItem`: Row displaying folder icon, name, and note count.
- `InsightRibbonItem`: Icon + Large Text + Label for dashboard stats.

### Organisms (Complex Sections)
- `WaveformVisualizer`: Renders live audio buffers and physical markers.
- `TranscriptStream`: Scrollable area handling text chunks and paragraphing.
- `HighlightsPanel`: Container managing multiple `TagChip`s with filter states.
- `PhotoGalleryCarousel`: Horizontal list of `NotePhoto` widgets.

## 4. Component Inventory Table
| Component | Type | Purpose | Props | States | Reusability | Source |
|-----------|------|---------|-------|--------|-------------|--------|
| `NoteCard` | Molecule | Display note summary in list | `title`, `date`, `duration`, `tags` | Default, Pressed, Multi-select | High | Custom |
| `SearchBar` | Molecule | Filter local database | `onChanged`, `hintText` | Empty, Focused, Filled | High | Custom |
| `WaveformVisualizer` | Organism | Display audio amplitude | `stream`, `markers` | Idle, Active, Paused | Low (Specific to recording) | Custom |
| `TranscriptStream` | Organism | Render live/saved text | `textChunks`, `onWordTap` | Streaming, Static, Editing | Medium | Custom |
| `HighlightsPanel` | Organism | Group extracted items | `actionItems`, `deadlines` | Loading, Populated, Empty | Medium | Custom |
| `PrimaryButton` | Atom | Standard user action | `label`, `onPressed`, `icon` | Enabled, Disabled, Loading | High | Custom |

## 5. Gap Analysis
As no external UI library (like Material/Cupertino defaults) is strictly mandated beyond Flutter's base, all components are marked as `Custom`. The project will require a highly reusable `ThemeExtension` to manage colors and typography globally to avoid drift between Atoms and Molecules.
