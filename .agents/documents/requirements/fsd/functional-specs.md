# Functional Specification Document (FSD): Notulensi

## 1. Overview
This document specifies the user interactions and detailed functional behaviors for the **Notulensi** application. It serves as a bridge between the high-level PRD and the low-level Technical Design (TDD).

## 2. User Interaction Flows

### 2.1 Audio Recording & Live Transcription (Core)
**Trigger**: User taps the FAB (Floating Action Button) from the Home screen.

| Step | Action | Response |
| :--- | :--- | :--- |
| 1 | Tap FAB | System requests microphone permission (if not granted). |
| 2 | Permission Granted | System initializes the `speech_to_text` engine and starts recording. |
| 3 | Audio Input | Real-time waveform update (UI) and transcript stream starts. |
| 4 | Stop Tap | System stops recording, persists the audio file and transcript to the Isar database. |
| 5 | Post-process | System automatically triggers the Rule-based Extraction engine in a background isolate. |

### 2.2 Highlight Extraction (Background)
**Trigger**: Completion of an audio recording session.

| Input | Logic | Output |
| :--- | :--- | :--- |
| **Commitment** | Sentences starting with "I will", "We need to", "Action item:". | Saved as an `ActionItem` linked to the note. |
| **Temporal** | Sentences containing "by Monday", "on Oct 12", "deadline is". | Saved as a `Deadline` linked to the note. |

### 2.3 Note Management & Search
**Trigger**: Home screen view or search bar input.

- **Note List**: Displays all saved notes sorted by `createdAt` (descending). Each card shows the title, date, and a snippet of the transcript.
- **Full-Text Search**: As the user types in the search bar, the list filters results in < 100ms based on matches in the transcript text or title.
- **Note Details**: Tapping a note card opens the full transcript view with toggleable panels for 'Action Items' and 'Deadlines'.

## 3. Screen Specifications

### 3.1 Home Screen (Dashboard)
- **Top Bar**: App name and Search input field.
- **List View**: Paginated list of meeting notes.
- **FAB**: Prominent 'Record' button with pulse animation.
- **Bottom Banner**: AdMob non-intrusive ad.

### 3.2 Recording Screen (Active)
- **Header**: Duration timer (HH:MM:SS).
- **Body**: Waveform visualization and scrolling transcript area.
- **Actions**: 'Cancel' (Discard) and 'Stop' (Save).

### 3.3 Note Detail Screen
- **Title View**: Editable note title.
- **Highlights Bar**: Tabs for 'Action Items' and 'Deadlines' with badges indicating count.
- **Transcript Area**: Selectable and copyable text view of the full session.
- **Actions**: 'Export' (PDF/TXT) and 'Delete'.

### 3.4 Settings Screen
- **Storage Info**: Displays used storage (MB) and total available space.
- **Language Management**: Link to system speech settings to download offline language packs.
- **About/License**: Credits and legal information.

## 4. Input & Output Behavior

### 4.1 Data Input
- **Microphone**: Mono PCM 16-bit 16kHz audio stream.
- **Text Input**: Manual title editing and transcript corrections.

### 4.2 Data Output
- **PDF Export**: Standardized A4 document format with header, highlights, and transcript body.
- **TXT Export**: Raw text file formatted as UTF-8.
- **Share Sheet**: Standard Android/iOS sharing dialog.

## 5. Error & Exception Handling
- **Low Storage**: System displays a warning banner when device storage < 50MB and prevents new recording starts.
- **Mic Busy**: Informative error dialog if another application is holding the audio focus.
- **STT Failure**: If system STT fails or language pack is missing, user is guided to OS settings.
