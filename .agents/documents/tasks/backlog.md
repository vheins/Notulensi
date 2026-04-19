# Task Backlog: Notulensi

## Phase 1: Project Foundation
- **[TASK-001] Flutter Project Setup:** Initialize Flutter project with folder structure and basic routing.
- **[TASK-002] Tech Stack Integration:** Add dependencies: `isar`, `isar_flutter_libs`, `path_provider`, `permission_handler`, `google_mobile_ads`.
- **[TASK-003] Local Database Schema:** Define Isar schemas for `Note` (title, timestamp, transcript, audioPath) and `Highlight` (type, content, index).
- **[TASK-004] Theme & Styling:** Implement the distraction-free UI theme using Vanilla CSS-like Flutter styling.

## Phase 2: Core Audio & STT Engine
- **[TASK-005] Audio Recording Implementation:** Integrate `record` package for high-quality local audio capture.
- **[TASK-006] Offline STT Integration:** Implement `vosk_flutter` or equivalent for 100% offline transcription.
- **[TASK-007] Real-time Transcript UI:** Build a reactive UI component to display live transcription during recording.
- **[TASK-008] State Management for Recording:** Implement `flutter_bloc` or `provider` to handle recording states (idle, recording, paused, saving).

## Phase 3: Note Management & UI
- **[TASK-009] Home Screen (Note List):** Build the main dashboard with sorting, searching, and FAB for new recording.
- **[TASK-010] Note Detail View:** Create the viewer for saved notes, displaying full transcript and extracted highlights.
- **[TASK-011] Note Edit/Delete Logic:** Implement CRUD operations for note metadata and transcripts.
- **[TASK-012] Global Search:** Implement high-performance local search across all Isar collections.

## Phase 4: Rule-based Extraction & Export
- **[TASK-013] Rule Engine Development:** Create deterministic regex-based parser for Action Items and Deadlines.
- **[TASK-014] TXT Export Service:** Implement plain text export functionality.
- **[TASK-015] PDF Export Service:** Integrate `pdf` package to generate formatted summaries.
- **[TASK-016] Share Sheet Integration:** Use `share_plus` to handle exported file distribution.

## Phase 5: Polish & Monetization
- **[TASK-018] Storage Settings:** Build UI to show disk usage and manage recording files.
- **[TASK-019] Edge Case Handling:** Implement error states for permissions, storage full, and recording interruptions.
- **[TASK-020] Performance Optimization:** Benchmark transcription lag and Isar query speed; optimize where needed.
