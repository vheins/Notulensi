# Modal Overlay Design: Active Recording

## 1. Modal Info
- **Name**: ActiveRecordingModal
- **Type**: Fullscreen Dialog (`showGeneralDialog` in Flutter)
- **Trigger**: User taps the FAB on the Home Dashboard.
- **Content**: Waveform visualizer, live transcript, timer, and capture controls.

## 2. Trigger & State Changes
- **Trigger Element**: `FloatingActionButton` (Mic Icon).
- **State Change**: `RecordingCubit` transitions from `Idle` to `Initializing` -> `Recording`.
- **System Change**: App requests `Wakelock` to keep screen on. Intercepts hardware volume keys.

## 3. Structure & Layout
- **Header**: Contains the "Cancel" (X) button on the left, and a red pulsing timer on the right.
- **Body**: Split into a scrollable `TranscriptStream` (top 60%) and a fixed `WaveformVisualizer` (bottom 20%).
- **Footer**: Fixed control bar containing "Stop" (Large, Center), "Marker" (Left), and "Photo" (Right).

## 4. Dismissal Logic
- **Backdrop Click**: Disabled (`barrierDismissible: false`). The user MUST explicitly tap Stop or Cancel to avoid accidental data loss.
- **Android Back Button (Pop)**: Intercepted via `WillPopScope`. Triggers the "Cancel" confirmation dialog instead of closing.
- **Cancel Button**: Opens a secondary `AlertDialog` asking "Discard this recording? [Yes] [No]".
- **Stop Button**: Saves the file, closes the modal, and pushes the `NoteDetailRoute`.

## 5. Animation & Motion
- **Entry**: Slide up from bottom (Duration: 300ms, Easing: `Curves.easeOutCubic`).
- **Exit**: Slide down to bottom (Duration: 250ms, Easing: `Curves.easeInCubic`).
- **Reduced Motion**: If OS accessibility settings request reduced motion, fallback to a simple Fade in/out.

## 6. Stacking & Z-Index
- Rendered above the root navigator.
- If the "Cancel" confirmation dialog appears, it stacks *above* this fullscreen modal. `FocusTrap` ensures the user cannot interact with the recording while the dialog is open.

## 7. Accessibility
- `semanticsLabel`: "Active Recording Screen".
- Focus immediately jumps to the "Stop Recording" button upon opening for quick access via VoiceOver/TalkBack.
- "Marker" button announces "Bookmark added at [Time]" when tapped.
