# Product Roadmap: Notulensi

This roadmap maps the project backlog and requirements into development phases, focusing on the transition from a local recorder to a comprehensive private meeting assistant.

## Phase 1: Core Infrastructure
**Goal:** Establish foundational architecture, local database, and core audio/STT capabilities.

*   **Milestone 1.1: Project Setup & Database Initialization**
    *   Flutter setup with Isar (unencrypted) and basic routing.
    *   Core tech stack: `path_provider`, `permission_handler`, `google_mobile_ads`.
*   **Milestone 1.2: Audio Capture & Transcription Engine**
    *   Local audio capture using `record`.
    *   100% offline STT engine integration (System STT/Vosk).
    *   Reactive UI for live transcription and waveform.

## Phase 2: Core Utility & Monetization
**Goal:** Develop the core user experience and initial monetization.

*   **Milestone 2.1: Note Management & Global Search**
    *   Home screen with search and CRUD operations.
    *   Note detail view with transcript and basic highlights.
*   **Milestone 2.2: Rule-Based Extraction & Export**
    *   Deterministic regex-based parser for Action Items and Deadlines.
    *   Basic PDF/TXT export using standard templates.
*   **Milestone 2.3: AdMob Integration**
    *   Integrate banner/interstitial ads for revenue.

## Phase 3: Physical Security & Interaction
**Goal:** Enhance data protection and user interaction during capture.

*   **Milestone 3.1: Physical Safe-Box**
    *   Implement database encryption for Isar.
    *   Integrate Biometric authentication (Fingerprint/FaceID) to unlock the app.
*   **Milestone 3.2: Advanced Capture Features**
    *   Implement **Visual Waveform Markers** (Bookmarks/Stars during recording).
    *   Basic **Smart Speaker Tagging** (VAD-based separation).

## Phase 4: Smart Local Intelligence
**Goal:** Add high-value "pro" features that remain 100% offline.

*   **Milestone 4.1: Privacy & Workflow Integration**
    *   **Privacy Masking**: Local regex-based redaction engine for sensitive data.
    *   **Audio-to-Calendar**: Local system calendar bridge for extracted deadlines.
*   **Milestone 4.2: Ecosystem & Personalization**
    *   **Local Context Linking**: Inter-note relationship mapping and keyword bridging.
    *   **Offline Template Engine**: Multi-format customizable PDF exports.

## Phase 5: Productivity & Ecosystem
**Goal:** Expand utility with advanced ML and offline connectivity.

*   **Milestone 5.1: Audio Intelligence & Control**
    *   **Noise Suppression**: Local ML filter to clean audio in noisy environments.
    *   **Local Voice Commands**: Hands-free app control (Start/Stop/Mark).
*   **Milestone 5.2: Professional Management**
    *   **Project/Client Folders**: Advanced note organization.
    *   **Note Versioning**: Local history of transcript edits.
    *   **Insight Dashboard**: Weekly productivity statistics.
*   **Milestone 5.3: Zero-Network Connectivity**
    *   **QR-Code Sync**: Sharing notes between devices via QR scanner.
    *   **Automatic SD-Card Backup**: Skema cadangan lokal ke memori eksternal.
    *   **PiP Transcripts**: Multitasking support during recording.
