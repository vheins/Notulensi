# MVP Scope Definition: Notulensi

## 1. MoSCoW Table
| Feature | Category | Rationale | Effort |
| :--- | :--- | :--- | :--- |
| **Offline Audio Recording** | Must | Core functionality for capturing meetings. | M |
| **Offline Transcription (STT)** | Must | Primary value prop (Privacy + Utility). | L-M (using engine) |
| **Local Note Storage (Isar/Hive)** | Must | Data residency and fast retrieval. | S |
| **Rule-based Processing** | Must | Extracting deadlines/action items deterministically. | S |
| **Note CRUD & Search** | Must | Management and discovery of captured notes. | S |
| **Export to TXT/PDF** | Must | Portability and filing without cloud. | S |
| **Speaker Diarization** | Could | Hard to do accurately offline/locally. | XL |
| **Cloud Sync** | Won't | Directly violates "100% Offline" core objective. | L |

## 2. Definition Statement
The Notulensi MVP is a focused tool that enables individual professionals to record, transcribe, and structure meeting notes locally on their mobile device. The scope is strictly limited to deterministic, rule-based text extraction and local storage to ensure 100% privacy and zero-server dependency. Any feature requiring external data transmission is excluded from this version.

## 3. Success Metrics
* **Transcription Lag:** Average time from "Stop Recording" to "Transcript Visible" < 5s.
* **Accuracy:** > 80% word error rate (WER) for clear voice in target language.
* **Extraction Quality:** Correctly identifies > 70% of manual "deadlines" and "actions" in test transcripts.
* **APK Size:** Final release binary < 25MB (excluding optional downloadable models).

## 4. Risk Flags
* **STT Library Performance:** If `speech_to_text` fallback is inconsistent across Android versions. (Mitigation: Use Vosk as primary engine).
* **Battery Drain:** Long recordings might consume high power. (Mitigation: Optimize recording buffer and async processing).
