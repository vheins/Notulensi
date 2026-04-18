# Module Documentation: feature_recording

## 1. Responsibility
The `feature_recording` module manages the audio capture process and coordinates with the STT engine for real-time transcription.

## 2. Architecture
- **Layer**: Presentation & Data.
- **Logic**: `RecordingCubit` for state management; `AudioRepository` for hardware interaction.
- **Plugin**: `record` (Audio) & `speech_to_text` (Transcription).

## 3. Workflows
- **STT Model Management**: Check STT model status via `speech_to_text`.
  - States: `Not Downloaded`, `Downloading`, `Ready`, `Failed`.
  - State emitted to UI blocks recording unless `Ready`.
- **Start Recording**: Request mic permission -> Initialize STT -> Open audio stream.
- **Live Stream**: Simultaneously pipe audio to filesystem and text engine.
- **Error Handling**: Graceful recovery if mic focus is lost or OS terminates the background task.

## 4. User Stories
- **US-001**: Record audio directly in the app.
- **US-002**: View real-time transcript updates.

## 5. Test Architecture
This module adheres to the mandatory 4-concern test strategy:
- **Database Testing**: Verify storage logic for audio paths.
- **Service Testing**: Mock STT/Audio services and test `RecordingRepository`.
- **State Management Testing**: Test `RecordingCubit` state emissions (e.g., initialized, recording, paused, stopped).
- **UI Testing**: Widget test for recording screen UI elements and states.

## 6. Test Scenarios
| Type | Scenario | Expected Result |
| :--- | :--- | :--- |
| **Positive** | Start recording after permission grant. | Stream starts; UI shows waveform. |
| **Negative** | User denies mic permission. | App shows helpful dialog and disables recording. |
| **Edge** | Incoming call during recording. | Recording pauses; resumes or saves based on session state. |
| **Security** | Mic activity indicator. | OS native indicator is visible (Privacy compliance). |
