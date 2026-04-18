# Testing: Recording

## Test Architecture
This module adheres to the mandatory 4-concern test strategy:
- **Database Testing**: Verify storage logic for audio paths.
- **Service Testing**: Mock STT/Audio services and test `RecordingRepository`.
- **State Management Testing**: Test `RecordingCubit` state emissions (e.g., initialized, recording, paused, stopped).
- **UI Testing**: Widget test for recording screen UI elements and states.

## Test Scenarios
| Type | Scenario | Expected Result |
| :--- | :--- | :--- |
| **Positive** | Start recording after permission grant. | Stream starts; UI shows waveform. |
| **Negative** | User denies mic permission. | App shows helpful dialog and disables recording. |
| **Edge** | Incoming call during recording. | Recording pauses; resumes or saves based on session state. |
| **Security** | Mic activity indicator. | OS native indicator is visible (Privacy compliance). |
