# Screen Wireframe Specification: Recording Screen

## 1. Screen Info
- **Screen Name**: Recording Screen (Active Capture)
- **Device**: Mobile (Primary), Tablet (Adaptive)
- **Dimensions**: 390x844 (Mobile Base)
- **Purpose**: Allow the user to view live audio waveform, real-time transcription, and drop markers while capturing a meeting securely offline.

## 2. Layout Zones (ASCII Wireframe)
```text
+------------------------------------------+
|  [<] Cancel                00:15:42      | HEADER
+------------------------------------------+
|                                          |
|                                          |
|  [ Live Transcript Area ]                | MAIN CONTENT
|  "We need to finalize the PRD by..."     | (Scrollable)
|  "I will send the email."                |
|                                          |
|                                          |
+------------------------------------------+
|  [ --- Waveform Visualization --- ]      | AUDIO ZONE
+------------------------------------------+
|                                          |
|    [Marker]      [Camera]      [Stop]    | CONTROLS
|                                          |
+------------------------------------------+
```

## 3. Content Blocks & Component Mapping
| Block | Position | Content / Behavior | Priority |
|-------|----------|--------------------|----------|
| **Timer / Status** | Header (Top Right) | Active recording duration (HH:MM:SS) pulsing red. | High |
| **Live Transcript** | Main Content | Scrollable text view. Auto-scrolls to bottom as new text arrives via local STT. | High |
| **Waveform** | Audio Zone (Lower) | Real-time audio amplitude bars moving right-to-left. Displays dropped markers. | High |
| **Primary Controls**| Bottom Center | Large FAB for 'Stop'. Smaller flanking FABs for 'Marker' and 'Camera'. | Critical |

## 4. Interactive Elements & Flow
| Element | Type | Action / Destination |
|---------|------|----------------------|
| **Cancel Button** | Icon Button | Pauses recording, shows confirmation dialog -> Discard -> Back to Home. |
| **Stop Button** | Primary FAB | Ends recording -> Triggers Extraction Isolate -> Navigates to Note Detail Screen. |
| **Marker Button** | Icon Button | Drops a timestamped star on the waveform/transcript. Haptic feedback. |
| **Camera Button** | Icon Button | Opens native camera -> captures photo -> embeds thumbnail at current timestamp. |

## 5. States to Wireframe (Figma Hand-off)
- [x] **Active Recording**: Standard state with flowing transcript.
- [x] **Paused State**: Waveform static, 'Stop' becomes 'Save', 'Pause' becomes 'Resume'.
- [x] **PiP Mode (System)**: Minimized overlay showing only the timer and the last transcribed sentence.

## 6. Annotations
1. **No Save Button**: The 'Stop' button inherently means "Save and Process" to reduce clicks.
2. **Volume Keys**: The entire screen listens for hardware volume-up/down events to drop markers without touching the screen.
3. **Responsive**: On tablets, the layout switches to a 2-column view (Transcript on left, Waveform/Controls on right).
