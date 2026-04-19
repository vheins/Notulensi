# Functional Specification Document (FSD): Notulensi

## 1. Overview
This document specifies user interactions and detailed functional behaviors for the **Notulensi** application, serving as the bridge between PRD and Technical Design.

## 2. Core Interaction Flows

### 2.1 Secured Access (Safe-Box)
**Trigger**: App launch or background-to-foreground transition.
1. System displays a biometric prompt.
2. User provides Fingerprint/FaceID.
3. On success, Note List is decrypted and displayed.

### 2.2 Advanced Recording (Interaction)
**Trigger**: User taps FAB or shakes device.
1. System starts capturing audio.
2. **Markers**: User taps waveform, smartwatch, or volume keys to drop a bookmark.
3. **Multimedia**: User taps 'Camera' to take a timestamped photo.
4. **Voice Command**: User says "Stop" to finish.

### 2.3 Local Processing (Intelligence)
**Trigger**: Recording stop event.
1. **Trimmer**: Silent gaps > 3s are removed from PCM buffer.
2. **Noise Filter**: Local ML cleans the audio.
3. **STT**: Local engine transcribes speech.
4. **Parser**: Action items, deadlines, and PII (for masking) are identified.

## 3. Screen Specifications

### 3.1 Home Screen (Secured)
- **Folder Navigation**: Sidebar or tab-view for custom project folders.
- **Search**: Scoped search (current folder) vs Global search.
- **Privacy Lock**: Visual indicator of encrypted state.

### 3.2 Recording Screen (Rich)
- **Live Transcript**: Scrollable text with auto-paragraphing (Speaker Tagging).
- **Control Bar**: Add Marker (Star icon), Take Photo (Camera icon), Pause/Stop.
- **Waveform**: Interactive waveform with visible marker points.

### 3.3 Note Detail Screen (Dynamic)
- **Redaction Toggle**: Button to mask/unmask sensitive info in the view.
- **Version History**: Bottom sheet displaying manual edit snapshots.
- **Multimedia Gallery**: Horizontal carousel of meeting photos synced to text.
- **Actions**: Export (with template picker), Sync to Calendar, Share via QR.

### 3.4 Settings & Reward Center
- **Monetization**: "Watch Ad to Unlock Pro" button (Reward-unlocked templates).
- **Backup**: "Export Encrypted Backup to SD" action.
- **STT Settings**: Link to OS language settings + Pro model download.

## 4. Input & Output Behavior

### 4.1 Data Input
- **Biometric**: Fingerprint/FaceID tokens.
- **Hardware**: Volume button interrupts.
- **Camera**: Raw image data (anchored to ms).

### 4.2 Data Output
- **QR Sync**: Multi-part high-density QR codes.
- **Calendar**: Native `EKEvent` (iOS) or `CalendarContract` (Android) data.
- **PDF**: Multi-template documents generated via `pdf` package.
