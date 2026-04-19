# Product Requirements Document (PRD): Notulensi

## 1. Executive Summary
**Notulensi** is a privacy-first, 100% offline meeting assistant. It provides real-time local transcription and automated structuring of meeting data directly on the device, maximizing hardware capabilities without compromising data privacy.

### 1.1 Project Goals
- **Privacy First**: Absolute local data residency for all meeting content.
- **Offline Reliability**: Zero dependence on internet for core logic.
- **Advanced Interaction**: Leveraging hardware buttons and multimedia for a richer note-taking experience.
- **Sustainable Monetization**: Balanced approach using AdMob Rewards and Pro features.

## 2. Target Audience
- **Corporate & Legal**: Strict privacy and security needs.
- **Researchers & Students**: Needing structured data from long recordings.
- **Tech-Savvy Professionals**: Utilizing hardware gestures and smartwatch controls.

## 3. Product Features

### 3.1 Recording & Interaction
- **Hybrid STT & Noise Suppression**: OS-native STT with local ML audio cleaning.
- **Hardware Gestures**: Volume-key bookmarking and Shake-to-Memo.
- **Smartwatch Remote**: Bluetooth-based control from WearOS/Apple Watch.
- **Waveform Markers**: Bookmarks/stars dropped during live capture.

### 3.2 Multimedia & Intelligence
- **Multimedia Metadata**: In-app photos synced to transcript timestamps.
- **Smart Speaker Tagging**: Local VAD-based speaker separation.
- **Privacy Masking**: Local redaction of PII (names, numbers).
- **Auto-Silence Trimmer**: Automatic removal of long pauses from audio files.

### 3.3 Analytics & Security
- **Physical Safe-Box**: Database encryption (Isar) with Biometric Lock.
- **Local Analytics**: Speech speed (WPM) charts and Keyword Heatmaps.
- **Context Linking**: Semantic indexing between related local notes.

### 3.4 Monetization & Ecosystem
- **Reward System**: AdMob Reward-unlocked premium PDF templates and masking.
- **QR-Code Sync**: Local zero-network transcript sharing.
- **P2P Collaboration**: Multi-device sync via WiFi Direct for higher accuracy.

## 4. Technical Constraints
- **Platform**: Flutter (Android/iOS).
- **Database**: Isar (Local, NoSQL, Encrypted).
- **Networking**: Strictly limited to AdMob (rewards/banners) and language pack management.

## 5. Success Metrics
- **Transcription Latency**: < 500ms from speech to UI.
- **Hardware Integration**: > 30% of power-users utilizing Volume-key/Smartwatch features.
- **Monetization Conversion**: Strong engagement with Reward-unlocked features.

## 6. Roadmap Expansion
- **V1.0**: Recording, STT, Regex Extraction, Isar, Basic PDF.
- **V1.1 (Security)**: Biometric Safe-Box, Waveform Markers.
- **V1.2 (Intelligence)**: Speaker Tagging, Privacy Masking, Calendar Integration.
- **V1.3 (Productivity)**: Folders, Versioning, Noise Suppression.
- **V1.4 (Interaction)**: Volume-key gestures, Smartwatch Remote, In-app Photos.
- **V1.5 (Analytics & Rewards)**: Speech Analytics, Reward-unlocked features, P2P Sync.
