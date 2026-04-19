# Sprint Plan: Notulensi

This document breaks down the tasks from the backlog and maps them to sprint cycles. Each task is assigned estimated story points and defining acceptance criteria. Sprints are nominally 2 weeks.

## Sprint 1: Foundation & Database (Phase 1)
**Focus:** Project initialization and local database creation.

| Task ID | Description | Story Points | Acceptance Criteria |
| :--- | :--- | :---: | :--- |
| **TASK-001** | Flutter Project Setup | 2 | Flutter project runs on emulator/device; folder structure is defined; basic routing works. |
| **TASK-002** | Tech Stack Integration | 2 | `isar`, `permission_handler`, and other base packages are installed and initialized without errors. |
| **TASK-003** | Local Database Schema | 5 | Isar schemas for `Note` and `Highlight` are generated; basic read/write tests pass. |
| **TASK-004** | Theme & Styling | 3 | Global CSS-like distraction-free theme is implemented and applied to sample widgets. |

## Sprint 2: Core Audio & STT (Phase 1)
**Focus:** Offline audio recording and real-time transcription integration.

| Task ID | Description | Story Points | Acceptance Criteria |
| :--- | :--- | :---: | :--- |
| **TASK-005** | Audio Recording Implementation | 5 | App can capture audio locally using `record` and save files to device storage. |
| **TASK-006** | Offline STT Integration | 8 | App transcribes speech to text using an offline engine without network calls. |
| **TASK-007** | Real-time Transcript UI | 5 | UI displays transcribed text dynamically as the user speaks, along with audio waveform. |
| **TASK-008** | State Management for Recording | 3 | Recording states (idle, recording, saving) are managed correctly via `flutter_bloc`. |

## Sprint 3: Note Management UI (Phase 2)
**Focus:** User interface for viewing, searching, and managing saved notes.

| Task ID | Description | Story Points | Acceptance Criteria |
| :--- | :--- | :---: | :--- |
| **TASK-009** | Home Screen (Note List) | 5 | Dashboard displays saved notes sorted by date; FAB navigates to the recording screen. |
| **TASK-010** | Note Detail View | 5 | Clicking a note opens a detailed view showing the full transcript and highlighting functionality. |
| **TASK-011** | Note Edit/Delete Logic | 3 | Users can delete a note (and its audio) or edit metadata/transcript; changes persist to Isar. |
| **TASK-012** | Global Search | 3 | Users can search keywords and instantly see matching notes using Isar full-text search. |

## Sprint 4: Extraction Engine & Export (Phase 2 & 3)
**Focus:** Automated rule-based engine for highlights and data export capabilities.

| Task ID | Description | Story Points | Acceptance Criteria |
| :--- | :--- | :---: | :--- |
| **TASK-013** | Rule Engine Development | 8 | Engine accurately identifies and extracts action items and deadlines from transcript text using regex. |
| **TASK-014** | TXT Export Service | 2 | Users can export a note as a `.txt` file. |
| **TASK-015** | PDF Export Service | 5 | Users can export a note as a formatted `.pdf` document containing structured highlights. |
| **TASK-016** | Share Sheet Integration | 2 | Exported files can be shared using the native OS share sheet. |

## Sprint 5: Polish & Release (Phase 3)
**Focus:** Monetization, edge cases handling, and performance tuning for production.

| Task ID | Description | Story Points | Acceptance Criteria |
| :--- | :--- | :---: | :--- |
| **TASK-018** | Storage Settings | 5 | Users can view disk usage and delete old recordings from a visual Settings dashboard. |
| **TASK-019** | Edge Case Handling | 5 | App gracefully handles denied mic permissions, full storage, and incoming calls during recording. |
| **TASK-020** | Performance Optimization | 5 | Transcription latency is < 500ms; UI does not freeze during long recordings or searches. |
