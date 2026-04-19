# Product Requirements Document (PRD): Notulensi

## 1. Executive Summary
**Notulensi** is a privacy-first, 100% offline meeting notes application built with Flutter. It provides real-time transcription and automated extraction of action items and deadlines directly on the device. By eliminating the need for cloud services, it ensures that sensitive conversation data remains strictly under the user's control.

### 1.1 Project Goals
- **Privacy First**: 0% data transmission to external servers.
- **Offline Reliability**: Works in airplane mode or remote areas.
- **Automated Structure**: Reduces manual note-taking through rule-based highlight extraction.
- **Performance**: APK size < 25MB and low-latency local processing.

## 2. Target Audience
- **Corporate Professionals**: Handling sensitive board/client meetings.
- **Project Managers**: Needing quick extraction of deliverables and deadlines.
- **Privacy Advocates**: Users who do not trust cloud-based transcription services.

## 3. Product Features

### 3.1 Recording & Transcription
- **Hybrid Offline STT**: Utilizes System STT (OS-native) for minimal APK impact while supporting 100% offline operation via downloaded language packs.
- **Real-time Feedback**: Live transcript scrolling and audio waveform visualization.
- **Audio Persistence**: Compressed local storage of recording sessions.

### 3.2 Automated Intelligence (Rule-Based)
- **Action Item Extraction**: Identification of tasks using linguistic triggers (e.g., "I will", "action item").
- **Deadline Extraction**: Detection of dates and temporal markers (e.g., "by Friday", "Oct 12").
- **Manual Overrides**: Ability to manually tag or edit extracted items.

### 3.3 Note Management
- **Full-Text Search**: Local indexing of transcripts for instant retrieval.
- **Storage Management**: Visual dashboard for monitoring app storage usage and cleaning old sessions.
- **CRUD Operations**: Complete management of meeting notes and associated audio files.

### 3.4 Export & Sharing
- **PDF Summaries**: Professional documents containing structured highlights and the full transcript.
- **TXT Export**: Raw data portability for external use.
- **System Share Sheet**: Integration with native sharing workflows.

## 4. User Stories & Acceptance Criteria

### 4.1 Core Workflows
| ID | User Story | Primary Acceptance Criteria |
| :--- | :--- | :--- |
| **US-004** | 100% Offline Operation | No network calls during recording or transcription (AC-011). |
| **US-010** | Action Item Extraction | Automatic highlighting of tasks based on keywords (AC-007). |
| **US-014** | Export PDF | Generation of a professional summary with structured data (AC-009). |

*Full lists available in `.agents/documents/requirements/user-stories.md` and `acceptance-criteria.md`.*

## 5. Technical Constraints
- **Platform**: Flutter (Android/iOS).
- **Database**: Isar (Local, NoSQL).
- **Size**: < 25MB initial APK.
- **Networking**: Strictly limited to AdMob (unobtrusive banners) and optional OS language pack management.

## 6. Success Metrics
- **Transcription Latency**: < 500ms from speech to UI text update.
- **Extraction Accuracy**: > 80% for explicitly stated action items.
- **Retention**: High user trust confirmed by zero data-leak incidents.

## 7. Roadmap (MVP)
- **V1.0**: Core recording, System STT integration, Keyword extraction (Action Items/Deadlines), Isar storage, PDF export.
- **V1.1**: Advanced search filters, multi-language support (manual pack trigger), custom extraction rules.
