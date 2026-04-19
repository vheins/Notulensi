# Acceptance Criteria (EARS Format): Notulensi

## 1. Recording & Transcription
- **AC-001 (Audio Capture):**
  - **WHEN** the user taps the 'Record' button,
  - **THE** system **SHALL** request microphone permissions (if not already granted) and start capturing audio.
- **AC-002 (Real-time Feedback):**
  - **WHILE** the recording is active,
  - **THE** system **SHALL** display a live waveform and a scrolling real-time transcript.
- **AC-003 (Offline Integrity):**
  - **WHERE** the device has no internet connection,
  - **THE** system **SHALL** perform transcription using local models (e.g., Vosk/Whisper.dart) without errors.
- **AC-004 (Data Saving):**
  - **WHEN** the user taps 'Stop',
  - **THE** system **SHALL** persist the audio file and the full transcript to the local Isar database within 2 seconds.

## 2. Note Management
- **AC-005 (Search Functionality):**
  - **WHEN** the user enters text in the search bar,
  - **THE** system **SHALL** filter the note list in real-time based on matches in the title or transcript text.
- **AC-006 (Note Deletion):**
  - **WHEN** the user selects 'Delete' on a note and confirms,
  - **THE** system **SHALL** remove the database record and the associated audio file from local storage.

## 3. Rule-based Extraction
- **AC-007 (Action Item Identification):**
  - **WHEN** the transcript contains phrases like "I will", "need to", or "action item",
  - **THE** system **SHALL** extract the following sentence as an 'Action Item' in the structured summary.
- **AC-008 (Deadline Extraction):**
  - **WHEN** the transcript contains date-related keywords (e.g., "by Monday", "on Oct 12"),
  - **THE** system **SHALL** tag the associated text as a 'Deadline'.

## 4. Exporting
- **AC-009 (PDF Generation):**
  - **WHEN** the user selects 'Export to PDF',
  - **THE** system **SHALL** generate a PDF containing the meeting title, date, structured highlights (Action Items/Deadlines), and the full transcript.
- **AC-010 (File Portability):**
  - **WHEN** a file is exported,
  - **THE** system **SHALL** open the native share sheet to allow the user to save it to their device or send it via other apps.

## 5. Non-Functional
- **AC-011 (Privacy Boundary):**
  - **THE** system **SHALL NOT** perform any network requests or transmit data to external servers.
- **AC-012 (Zero Internet Mandate):**
  - **THE** application **SHALL** remain fully functional and perform all core tasks (Recording, STT, Highlighting, Exporting) in environments with no internet access.
- **AC-013 (Storage Management):**
  - **THE** system **SHALL** display the total storage used by all meeting records in the 'Settings' menu.
