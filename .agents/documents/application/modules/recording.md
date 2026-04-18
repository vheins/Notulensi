# Module Documentation: feature_recording

## 1. Responsibility
The `feature_recording` module manages the audio capture process and coordinates with the STT engine for real-time transcription.

## 2. Architecture
- **Layer**: Presentation & Data.
- **Logic**: `RecordingCubit` for state management; `AudioRepository` for hardware interaction.
- **Plugin**: `record` (Audio) & `speech_to_text` (Transcription).

## 3. Workflows
- **Start Recording**: Request mic permission -> Initialize STT -> Open audio stream.
- **Live Stream**: Simultaneously pipe audio to filesystem and text engine.
- **Error Handling**: Graceful recovery if mic focus is lost or OS terminates the background task.

## 4. User Stories
- **US-001**: Record audio directly in the app.
- **US-002**: View real-time transcript updates.

## 5. Test Scenarios
| Type | Scenario | Expected Result |
| :--- | :--- | :--- |
| **Positive** | Start recording after permission grant. | Stream starts; UI shows waveform. |
| **Negative** | User denies mic permission. | App shows helpful dialog and disables recording. |
| **Edge** | Incoming call during recording. | Recording pauses; resumes or saves based on session state. |
| **Security** | Mic activity indicator. | OS native indicator is visible (Privacy compliance). |
