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

## 5. Scope (MVP)
The MVP is strictly limited to deterministic, rule-based text extraction and local storage to ensure 100% privacy and zero-server dependency.

**In Scope (Must Have):**
- Offline Audio Recording
- Offline Transcription (STT) via local engines (e.g., Vosk/SpeechToText)
- Local Note Storage (Isar/Hive)
- Rule-based Processing (Keyword/Regex extraction for deadlines and action items)
- Note CRUD & Search Operations
- Export to TXT/PDF for portability

**Out of Scope (Won't/Deferred):**
- Cloud Sync (Directly violates the core "100% Offline" objective)
- Multi-Speaker Diarization (High complexity, deferred from MVP)

## 6. Assumptions
- **User Assumptions:** Users are willing to trade "perfect" probabilistic AI summaries for "good enough" local, deterministic, and private rule-based extraction. Privacy is a stronger driver than cloud collaboration. Users prefer smaller APK sizes (< 25MB) over massive high-accuracy built-in models.
- **Technical Assumptions:** Modern mobile hardware can handle real-time STT without excessive battery drain or UI lag. Rule-based parsing is sufficient to extract key information from unstructured speech.
- **Business Assumptions:** The privacy-first market segment is large enough to sustain the app. Users will tolerate basic monetization (AdMob interstitials) or opt for a one-time "Pro" purchase over recurring subscriptions.

## 7. Feasibility
**Verdict: GO**
- **Technical (8/10):** Highly feasible due to the elimination of server-side infrastructure. Using Flutter with local STT engines and local databases provides a robust technical foundation.
- **Financial:** Viable with $0 backend infrastructure costs, enabling excellent scaling without increasing operational overhead.
- **Timeline:** A functional MVP can be built in 4-6 weeks due to the absence of backend/cloud complexity.
- **Risks & Mitigations:** 
  - *STT Accuracy & APK Size:* Mitigated by using smaller default models with options to download larger, more accurate models on-demand.
  - *Rule Hallucination:* Mitigated by keeping extraction rules simple (regex/keywords) and allowing manual text overrides in the UI.
