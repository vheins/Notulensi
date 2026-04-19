# Acceptance Criteria (EARS Format): Notulensi

## 1. Recording & Interaction
- **AC-001 (Audio Capture):**
  - **WHEN** the user taps the 'Record' button,
  - **THE** system **SHALL** request microphone permissions and start capturing mono PCM 16kHz audio.
- **AC-002 (Waveform & Markers):**
  - **WHILE** the recording is active,
  - **THE** system **SHALL** display a live waveform and allow the user to drop markers via UI taps, volume keys, or smartwatch remote.
- **AC-003 (Offline STT & Noise Suppression):**
  - **WHERE** the environment is noisy,
  - **THE** system **SHALL** apply a local ML noise filter before performing 100% offline transcription.
- **AC-014 (Voice Commands):**
  - **WHEN** the user speaks a registered command (e.g., "Stop Recording"),
  - **THE** system **SHALL** execute the corresponding action without requiring physical touch.
- **AC-015 (Multimedia Anchoring):**
  - **WHEN** a photo is taken during recording,
  - **THE** system **SHALL** store the image and link it to the current audio timestamp in the transcript.

## 2. Note Management & Security
- **AC-005 (Search & Context):**
  - **WHEN** a note is opened,
  - **THE** system **SHALL** highlight keywords that overlap with other local notes to facilitate context linking.
- **AC-016 (Biometric Safe-Box):**
  - **WHERE** the user has enabled biometric protection,
  - **THE** system **SHALL** require a valid fingerprint or face ID scan before granting access to the note list or encrypted database.
- **AC-017 (Project Folders):**
  - **THE** system **SHALL** allow users to create, rename, and move notes into custom folders for organization.
- **AC-018 (Versioning):**
  - **WHEN** a transcript is manually edited,
  - **THE** system **SHALL** create a snapshot of the previous state, allowing up to 5 versions to be stored locally.

## 3. Intelligence & Extraction
- **AC-007 (Action Item & Privacy Masking):**
  - **WHEN** the transcript is processed,
  - **THE** system **SHALL** extract action items and optionally mask PII (names/numbers) based on user preference.
- **AC-019 (Speaker Separation):**
  - **WHILE** transcribing,
  - **THE** system **SHALL** use VAD to detect pauses and tone shifts, inserting paragraph breaks to indicate speaker changes.
- **AC-020 (Calendar Bridge):**
  - **WHEN** a deadline is extracted,
  - **THE** system **SHALL** provide a "Sync to Calendar" button that opens the native OS calendar with pre-filled event details.

## 4. Export & Ecosystem
- **AC-009 (Template-Based Export):**
  - **WHEN** the user selects 'Export to PDF',
  - **THE** system **SHALL** allow selection from multiple local templates (Formal, Creative, Minimalist).
- **AC-021 (Zero-Network QR Sharing):**
  - **WHEN** the user selects 'Share via QR',
  - **THE** system **SHALL** compress the transcript and generate a high-density QR code for offline device-to-device transfer.
- **AC-022 (Auto-Silence Trimming):**
  - **WHEN** a recording is saved,
  - **THE** system **SHALL** analyze the audio and remove silent gaps exceeding 3 seconds to optimize storage.

## 5. Non-Functional & Monetization
- **AC-011 (Privacy Boundary):**
  - **THE** system **SHALL NOT** transmit any audio, transcript, or meeting metadata to external servers.
- **AC-012 (Ad & Reward Flow):**
  - **WHERE** the user is in a free tier,
  - **THE** system **SHALL** display AdMob banners and allow reward-ads to unlock premium local features.
- **AC-023 (Offline Integrity):**
  - **THE** application **SHALL** remain 100% functional for all core tasks in environments with no internet access (excluding ad delivery).
- **AC-013 (Storage Dashboard):**
  - **THE** system **SHALL** display per-note and total storage metrics, including space saved by the silence trimmer.
