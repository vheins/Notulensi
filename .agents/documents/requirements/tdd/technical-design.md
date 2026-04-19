# Technical Design Document (TDD): Notulensi

## 1. System Architecture
Notulensi utilizes a **Feature-based Clean Architecture** to ensure high performance and maintainability in an offline-first environment.

### 1.1 Layers
- **Presentation**: Flutter/Cubit (Reactive UI).
- **Domain**: Pure Dart Use Cases and Entities.
- **Data**: Isar Repository Implementations and Infrastructure (Audio, STT, File Sys).
- **External**: OS Speech Engine, File System, Isar Engine.

## 2. Technology Stack
- **Framework**: Flutter (v3.19+).
- **State Management**: `flutter_bloc` / `cubit` (Lighter for high-frequency updates like live transcription).
- **Database**: Isar (High-speed, 100% Offline, Full-text Search).
- **STT Engine**: `speech_to_text` (Wrapper for OS native STT engines).
- **Audio Management**: `record` and `audioplayers` packages.
- **Dependency Injection**: `get_it`.
- **Exporting**: `pdf` and `share_plus` packages.

## 3. Detailed Component Design

### 3.1 Speech-to-Text (Hybrid STT Strategy)
- **Engine Selection**: `speech_to_text` for minimal APK size.
- **Offline Check**: System checks for `onDevice` capability before session start.
- **User Prompt**: If missing, redirects to OS language pack download settings.

### 3.2 Isar Database Schema
```dart
@collection
class MeetingNoteCollection {
  late String id; // UUID format
  @Index(type: IndexType.value)
  late String title;
  late DateTime createdAt;
  late DateTime updatedAt;
  DateTime? deletedAt; // Soft delete support
  @Index(type: IndexType.value, caseSensitive: false)
  late String transcript; // Full-text search enabled
  late String audioPath;
  late int storageSize;
  final actionItems = IsarLinks<ActionItemCollection>();
  final deadlines = IsarLinks<DeadlineCollection>();
}

@collection
class ActionItemCollection {
  late String id; // UUID format
  late String content;
  late int startIndex;
  late int endIndex;
  bool isCompleted = false;
  late DateTime createdAt;
  late DateTime updatedAt;
}

@collection
class DeadlineCollection {
  late String id; // UUID format
  late String content;
  late String dateText;
  late DateTime deadlineDate;
  late int startIndex;
  late int endIndex;
  late DateTime createdAt;
  late DateTime updatedAt;
}
```

### 3.3 Rule-Based Highlight Engine
- **Implementation**: Background Dart Isolate (`compute`) to process transcript text.
- **Regex Rules**:
  - `ActionItem`: `\b(I|we)\s+(will|shall|must|need to)\s+([^.?!]+)`
  - `Deadline`: `\b(by|on)\s+(Monday|Tuesday|...|tomorrow)\b`
- **Output**: Direct batch-save to Isar linked collections.

## 4. Test Architecture (4-Concern Rule)
As per `.agents/rules/test-architecture.md`, all features must be verified across these layers:

| Layer | Focus | Key Scenarios |
| :--- | :--- | :--- |
| **1. Database** | Integrity & Persistence | UUID generation, IsarLinks integrity, Full-text index performance. |
| **2. Service** | Business Logic | Regex extraction accuracy, PDF generation formatting, Audio file compression. |
| **3. State** | Workflow & Guardrails | Recording state transitions, Permission request logic, Storage limit enforcement. |
| **4. UI** | Rendering & Validation | Waveform sync, Real-time scrolling transcript, Search result filtering. |

## 5. Performance & Resource Optimization
- **Audio Format**: Mono PCM or M4A (depending on OS support) to minimize storage footprint.
- **Memory Management**: Transcript text chunks are buffered and persisted periodically to avoid large single-write operations.
- **Battery**: STT engine is released immediately when recording stops.

## 6. Security & Privacy Model
- **Offline Mandate**: Zero networking dependencies in the core logic.
- **Storage Protection**: All audio files and database records are stored in the application's private directory (`get_application_documents_directory`).
- **Data Exfiltration Prevention**: No analytics or error-reporting packages that transmit data (e.g., Firebase Analytics/Crashlytics).

## 7. Implementation Milestones

### 7.1 Phase 1: Core Infrastructure
- Isar DB setup and generic repository.
- Audio recording session management.
- STT initialization and live-stream display.

### 7.2 Phase 2: Feature Implementation
- Highlight extraction engine development.
- Home screen dashboard and full-text search.
- Note detail view and manual correction logic.

### 7.3 Phase 3: Export & Polishing
- PDF/TXT export generation.
- Storage management dashboard in Settings.
