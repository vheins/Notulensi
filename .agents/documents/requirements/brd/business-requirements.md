# Business Requirements Document (BRD): Notulensi

## 1. Executive Summary
Notulensi is a 100% offline mobile application designed to securely capture, transcribe, and structure meeting notes. It targets privacy-conscious professionals who require immediate, actionable meeting summaries without the data privacy risks and connectivity dependencies associated with cloud-based AI transcription services.

## 2. Core Business Problem
Professionals and students frequently attend sensitive meetings where cloud-based recording and transcription services pose significant privacy risks, data residency concerns, and dependency on stable internet connections. 
- **Privacy & Security:** Cloud transcription processes data on 3rd party servers, creating risks of data breaches or unauthorized use of proprietary data for AI training.
- **Connectivity Dependency:** Cloud apps fail or degrade during critical sessions if there is no signal or poor Wi-Fi.
- **Lack of Structure in Offline Tools:** Existing local tools capture raw audio without structure, requiring hours of manual re-listening to extract action items or deadlines.

## 3. Target User Persona
**The Privacy-Conscious Professional** (e.g., Compliance Managers, Legal/Medical Consultants, HR, Research Students).
- **Goals:** Capture meetings without data leaving the physical device, receive immediately actionable structured bullets/deadlines, and maintain a portable, searchable local archive.
- **Frustrations:** Slow cloud processing, data silos that prevent easy export, and subscription fatigue.
- **Behavior:** Skeptical of "free" cloud tools, values 100% data ownership, uses encrypted local drives, and expects high-performance, distraction-free interfaces.

## 4. Value Proposition
For privacy-conscious professionals who need structured meeting notes without cloud risks, Notulensi is a 100% offline Flutter application that transcribes and automatically structures audio locally. 
- **Total Privacy:** Local on-device Speech-to-Text (STT) ensures zero bytes are sent to the cloud, guaranteeing full data residency and compliance.
- **Instant Structure:** Rule-based parsing provides instant extraction of deadlines and action items deterministically, avoiding "AI processing" delays and hallucinations.
- **Lightweight Speed:** Optimized local storage (Isar/Hive) provides instant search capabilities and fast startup.

## 5. Scope (Phased Evolution)
The project is strictly limited to deterministic, local storage to ensure 100% privacy and zero-server dependency for data processing.

**Phase 1 & 2 (Core Utility):**
- Offline Audio Recording & Transcription
- Local Note Storage (Isar/Hive)
- Rule-based Processing (Regex extraction)
- Note CRUD & Search Operations
- Export to TXT/PDF

**Phase 3 & 4 (Security & Intelligence):**
- **Physical Safe-Box**: Database encryption with Biometric Lock.
- **Smart Speaker Tagging**: Local VAD-based speaker separation.
- **Privacy Masking**: Regex-based local redaction of PII.
- **Local Context Linking**: Inter-note semantic indexing.
- **Audio-to-Calendar**: Local system calendar bridge.
- **Visual Waveform Markers**: In-recording bookmarks.

**Phase 5 (Productivity & Ecosystem):**
- **Audio Intelligence**: Offline Noise Suppression & Local Voice Commands.
- **Advanced Management**: Project/Client Folders & Note Versioning.
- **Offline Ecosystem**: QR-Code Note Sharing (Zero-Network) & SD-Card Backups.
- **Accessibility**: Picture-in-Picture (PiP) transcripts & Focus UI.

## 6. Assumptions
- **User Assumptions:** Users are willing to trade "perfect" probabilistic AI summaries for "good enough" local, deterministic, and private rule-based extraction. 
- **Technical Assumptions:** Modern mobile hardware can handle real-time STT, local database encryption, and noise suppression without excessive battery drain.
- **Business Assumptions:** The privacy-first market segment is large enough to sustain the app via AdMob rewards and a one-time "Pro" purchase for advanced local features.

## 7. Feasibility
**Verdict: GO**
- **Technical (8/10):** Highly feasible using Flutter with local engines. 
- **Financial:** Viable with $0 backend infrastructure costs.
- **Timeline:** Core MVP in 4-6 weeks; Advanced features rolled out in continuous 2-week cycles.
