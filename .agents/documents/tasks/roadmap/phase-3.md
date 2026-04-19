# Roadmap: Notulensi Phase 3 (Security & Interaction)

## Overview
Phase 3 focuses on hardening the application's security posture and enhancing user interaction via hardware and biometric triggers.

## 1. Security & Privacy Hardening
- [ ] **Biometric Safe-Box**: Implement `local_auth` integration with cubit state management.
- [ ] **Encrypted Persistence**: Configure Isar with AES-256 keys derived from `flutter_secure_storage`.
- [ ] **Privacy Redaction**: Develop the Regex Isolate to mask PII (Emails, Numbers) in real-time.
- [ ] **Sandboxed Assets**: Ensure all audio/image files are stored with `.nomedia` and in private app directories.

## 2. Advanced Interaction
- [ ] **Physical Key Markers**: Implement volume button listener using a foreground service (Android) and platform channels.
- [ ] **Waveform Bookmarking**: Build the interactive `WaveformVisualizer` widget with bookmark dropping logic.
- [ ] **Smartwatch Remote**: Develop the Bluetooth P2P protocol for simple Start/Stop/Marker sync.

## 3. Storage & Cleanup
- [ ] **Silence Trimmer**: Integrate a PCM buffer processor to remove gaps >3s post-recording.
- [ ] **Storage Dashboard**: Build the UI to show space saved and total local residency stats.

## 4. Monetization & Rewards
- [ ] **AdMob Integration**: Implement rewarded video ads to unlock premium export templates for 24 hours.

## Timeline (Estimated)
- **Weeks 1-2**: Security, Biometrics, and Encrypted DB.
- **Weeks 3-4**: Hardware interaction and UI Waveform.
- **Week 5**: Intelligence (Trimmer & Redaction).
- **Week 6**: AdMob and Final Polish.
