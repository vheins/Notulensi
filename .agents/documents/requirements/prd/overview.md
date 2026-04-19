# Product Requirements Document (PRD): Notulensi

## 1. Executive Summary
**Notulensi** is a privacy-first, 100% offline meeting notes application built with Flutter. It provides real-time transcription and automated extraction of action items and deadlines directly on the device. By eliminating the need for cloud services, it ensures that sensitive conversation data remains strictly under the user's control.

### 1.1 Project Goals
- **Privacy First**: 0% data transmission of meeting content to external servers.
- **Offline Reliability**: Works in airplane mode or remote areas.
- **Automated Structure**: Reduces manual note-taking through rule-based highlight extraction.
- **Physical Security**: Local encryption and biometric protection for stored data.

## 2. Target Audience
- **Corporate Professionals**: Handling sensitive board/client meetings.
- **Legal & Medical**: Requiring strict data residency and compliance.
- **Privacy Advocates**: Users who do not trust cloud-based transcription services.

## 3. Product Features

### 3.1 Recording & Transcription
- **Hybrid Offline STT**: OS-native STT for minimal APK impact with local model support.
- **Real-time Feedback**: Live transcript scrolling and audio waveform visualization.
- **Waveform Markers**: Ability to drop bookmarks/stars on the waveform during recording.

### 3.2 Automated Intelligence (Local Only)
- **Rule-Based Extraction**: Action item and deadline detection via deterministic regex.
- **Smart Speaker Tagging**: Local speaker separation based on Voice Activity Detection (VAD).
- **Privacy Masking**: Local regex-based redaction of PII (names, numbers) before export.
- **Context Linking**: Automatic linking between related notes based on keyword overlap.

### 3.3 Note Management & Security
- **Physical Safe-Box**: Database encryption (Isar) unlocked via Biometrics (Fingerprint/FaceID).
- **Full-Text Search**: Local indexing of transcripts for instant retrieval.
- **Calendar Integration**: One-tap addition of detected deadlines to the local OS calendar.

### 3.4 Export & Sharing
- **Offline Template Engine**: Customizable PDF layouts (Formal, Creative, Minimalist).
- **System Share Sheet**: Integration with native sharing workflows.

## 4. User Stories & Acceptance Criteria
*See expanded lists in `.agents/documents/requirements/user-stories.md`.*

## 5. Technical Constraints
- **Platform**: Flutter (Android/iOS).
- **Database**: Isar (Local, NoSQL, Encrypted).
- **Networking**: Strictly limited to AdMob (rewards/banners) and optional OS language pack management.

## 6. Success Metrics
- **Transcription Latency**: < 500ms from speech to UI text update.
- **Security Adoption**: > 50% of users enable Biometric Safe-Box.
- **Offline Integrity**: 100% success rate for processing in zero-signal environments.

## 7. Roadmap Expansion
- **V1.0 (Core)**: Recording, STT, Regex Extraction, Isar, Basic PDF.
- **V1.1 (Security)**: Biometric Safe-Box, Waveform Markers.
- **V1.2 (Intelligence)**: Speaker Tagging, Privacy Masking, Calendar Integration.
- **V1.3 (Ecosystem)**: Context Linking, Advanced Template Engine.
