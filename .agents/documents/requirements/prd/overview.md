# Product Requirements Document (PRD): Notulensi

## 1. Executive Summary
**Notulensi** is a privacy-first, 100% offline meeting notes application built with Flutter. It provides real-time transcription and automated extraction of action items and deadlines directly on the device. By eliminating the need for cloud services, it ensures that sensitive conversation data remains strictly under the user's control.

### 1.1 Project Goals
- **Privacy First**: 0% data transmission of meeting content to external servers.
- **Offline Reliability**: Works in airplane mode or remote areas.
- **Automated Structure**: Reduces manual note-taking through rule-based highlight extraction.
- **Advanced Productivity**: High-value organizational tools that remain fully local.

## 2. Target Audience
- **Corporate Professionals**: Handling sensitive board/client meetings.
- **Legal & Medical**: Requiring strict data residency and compliance.
- **Privacy Advocates**: Users who do not trust cloud-based transcription services.

## 3. Product Features

### 3.1 Recording & Transcription
- **Hybrid Offline STT**: OS-native STT with local model support.
- **Noise Suppression**: Local ML-based audio cleaning.
- **Waveform Markers**: Bookmarks/stars dropped during live capture.
- **Voice Commands**: Hands-free control (e.g., "Stop Recording") via local recognition.

### 3.2 Automated Intelligence (Local Only)
- **Rule-Based Extraction**: Action item and deadline detection via regex.
- **Smart Speaker Tagging**: Local speaker separation via VAD.
- **Privacy Masking**: Local redaction of PII before export.
- **Context Linking**: Inter-note semantic indexing and cross-linking.

### 3.3 Note Management & Security
- **Physical Safe-Box**: Database encryption (Isar) with Biometric Lock.
- **Organization**: Project/Client folders and note versioning history.
- **Calendar Integration**: Local deadline sync.
- **Insight Dashboard**: Local statistics on meeting habits and productivity.

### 3.4 Sharing & Ecosystem
- **QR-Code Sync**: Local, zero-network sharing of transcripts via QR generation.
- **Offline Backups**: Encrypted exports to SD-Card or custom local folders.
- **Template Engine**: Customizable PDF formats (Formal, Minimalist, etc.).

## 4. User Stories & Acceptance Criteria
*See expanded lists in `.agents/documents/requirements/user-stories.md`.*

## 5. Technical Constraints
- **Platform**: Flutter (Android/iOS).
- **Database**: Isar (Local, NoSQL, Encrypted).
- **Networking**: Strictly limited to AdMob (rewards/banners) and optional OS language pack management.

## 6. Success Metrics
- **Transcription Latency**: < 500ms from speech to UI text update.
- **Security Adoption**: > 50% of users enable Biometric Safe-Box.
- **Offline Reliability**: 100% core feature availability in zero-signal environments.

## 7. Roadmap Expansion
- **V1.0 (Core)**: Recording, STT, Regex Extraction, Isar, Basic PDF.
- **V1.1 (Security)**: Biometric Safe-Box, Waveform Markers.
- **V1.2 (Intelligence)**: Speaker Tagging, Privacy Masking, Calendar Integration.
- **V1.3 (Productivity)**: Folders, Versioning, Noise Suppression.
- **V1.4 (Ecosystem)**: QR Sync, SD Backups, Voice Commands.
