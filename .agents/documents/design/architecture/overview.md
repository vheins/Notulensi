# System Architecture Overview: Notulensi

## 1. Architectural Pattern: Feature-based Clean Architecture

Notulensi follows a **Feature-based Clean Architecture** to ensure modularity, testability, and scalability while maintaining a lean codebase suitable for offline performance.

### 1.1 Layers
- **Presentation Layer (UI/UX)**: Flutter Widgets and State Management (Cubit/Bloc). Focuses on fast rendering and reactive updates.
- **Domain Layer (Business Logic)**: Pure Dart entities and Use Cases. This layer contains no external dependencies (database/STT).
- **Data Layer (Infrastructure)**: Implementation of repositories. Handles Isar Database interactions, File System (audio files), and STT Engine wrappers.
- **Core**: Shared utilities, constants, theme, and common dependency injection.

### 1.2 Component Diagram (Logical)
```
[ UI (Flutter) ] <--> [ Cubit/Bloc ]
                         |
                 [ Domain Entities/Use Cases ]
                         |
                 [ Repository Interfaces ]
                         ^
                         |
                 [ Data Implementation ]
                 /          |           \
        [ Isar DB ]    [ File Sys ]    [ STT Engine ]
```

## 2. Key Modules

### 2.1 Recording Module
- Handles audio session management.
- Streams audio data to the STT Engine.
- Provides real-time transcript updates to the UI.

### 2.2 Extraction Module (Rule-based)
- Operates on the final transcript string.
- Uses a pipeline of regex-based rules to identify Action Items and Deadlines.
- Runs as a background task after recording stops.

### 2.3 Note Management Module
- Handles listing, searching (Isar Full-text search), and CRUD operations.
- Manages storage cleanup (deleting audio files with DB records).

## 3. Performance & Startup Strategy
- **Lazy Initialization**: Database and STT engines are initialized only when needed.
- **Isar Speed**: Isar is selected for its synchronous capability and multi-isolate support, ensuring UI smoothness during heavy I/O.
- **Cold Boot Optimization**: Minimal dependency tree at startup.

## 4. Offline Integrity
- Zero `http` or `dio` dependencies in the core logic.
- All dependencies verified for 100% offline capability.
