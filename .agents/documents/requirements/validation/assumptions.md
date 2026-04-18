# Assumption Mapping: Offline Meeting Notes

## 1. User Assumptions
* **Assumption:** Users are willing to sacrifice "perfect" AI summaries for "good enough" local, private rules. (Risk: High | Experiment: Prototype rule-based parser on raw text).
* **Assumption:** Privacy is a stronger driver than "AI collaboration features." (Risk: Medium | Experiment: Landing page A/B test or user interviews).
* **Assumption:** Users prefer an APK < 20MB over a 500MB high-accuracy offline model. (Risk: High | Experiment: Test Vosk (small) vs. Whisper.cpp (large) performance).

## 2. Market Assumptions
* **Assumption:** The "Privacy-First" market segment is large enough to sustain an app. (Risk: Medium).
* **Assumption:** AdMob revenue is viable for a utility app with infrequent usage. (Risk: High).

## 3. Technical Assumptions
* **Assumption:** Mobile hardware can handle real-time STT without excessive battery drain. (Risk: High | Experiment: Stress test STT on mid-range Android/iOS).
* **Assumption:** Rule-based parsing is sufficient to extract "deadlines" and "actions" from messy speech. (Risk: Medium).

## 4. Business Assumptions
* **Assumption:** Users will tolerate Interstitial ads after stopping a long recording session. (Risk: Medium).
* **Assumption:** One-time purchase or "Rewarded Ads" for export is a valid conversion path. (Risk: Medium).

## 5. Priority Matrix
| Priority | Category | Risk | Rationale | Method |
| :--- | :--- | :--- | :--- | :--- |
| 1 | Technical | High | On-device STT must be accurate enough and fast. | PoC with Vosk/SpeechToText plugin. |
| 2 | User | High | Do users value offline over "AI perfection"? | User interview / Competitor review. |
| 3 | Technical | Medium | Rule-based parsing efficiency on raw transcripts. | Data testing on real meeting transcripts. |
| 4 | Business | Medium | AdMob viability and user tolerance for ads. | Competitor ad-strategy research. |
| 5 | Technical | Medium | APK size vs. Model performance trade-off. | Binary size analysis with modular models. |
