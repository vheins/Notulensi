# Product Roadmap: Notulensi

This roadmap maps the project backlog and requirements into 3 core development phases as defined in the Technical Design Document.

## Phase 1: Core Infrastructure
**Goal:** Establish the foundational architecture, local database, and core audio/STT capabilities.

*   **Milestone 1.1: Project Setup & Database Initialization**
    *   Initialize Flutter project with a scalable folder structure and basic routing.
    *   Integrate core tech stack packages (Isar, path_provider, permission_handler).
    *   Design and implement the Isar local database schemas for Notes and Highlights.
    *   Implement basic distraction-free UI theme.
*   **Milestone 1.2: Audio Capture & Transcription Engine**
    *   Integrate high-quality local audio capture using the `record` package.
    *   Implement 100% offline STT engine integration.
    *   Build reactive UI components for real-time transcription display.
    *   Manage application states for recording (idle, recording, paused, saving).

## Phase 2: Feature Implementation
**Goal:** Develop the core user experience for managing notes and the automated extraction engine.

*   **Milestone 2.1: Note Management & Global Search**
    *   Build Home Screen dashboard with note list, sorting, and searching functionality.
    *   Create Note Detail View to display transcripts and highlighted content.
    *   Implement CRUD operations (Edit/Delete) for individual notes and audio.
    *   Enable high-performance local search across all collections.
*   **Milestone 2.2: Rule-Based Extraction Engine**
    *   Develop deterministic regex-based parser to automatically extract Action Items and Deadlines from text.
    *   Integrate extraction background tasks for post-transcription processing.

## Phase 3: Export & Polishing
**Goal:** Finalize the application with export capabilities, monetization, and production-ready polish.

*   **Milestone 3.1: Export & File Sharing**
    *   Implement plain text (TXT) export service.
    *   Integrate PDF generation for formatted summaries containing structured highlights.
    *   Integrate native system share sheet for file distribution (`share_plus`).
*   **Milestone 3.2: Monetization & Performance Tuning**
    *   Integrate AdMob banner ads on Note List and Settings screens.
    *   Build a storage management dashboard within Settings.
    *   Handle edge cases (e.g., permissions denied, storage full, interruptions).
    *   Optimize transcription lag (< 500ms) and Isar query speed.
