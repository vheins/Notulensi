# Testing: Recording

## Test Architecture (4-Concern Rule)
This module adheres to the mandatory 4-concern test strategy:
- **Database Testing**: Verify storage logic for audio paths and metadata (UUID, audioPath).
- **Service Testing**: Mock STT/Audio services and test `RecordingRepository` (throughput and capture).
- **State Management Testing**: Test `RecordingCubit` state emissions (e.g., initialized, recording, paused, stopped).
- **UI Testing**: Widget test for recording screen UI elements, states, waveform sync, and transcript auto-scrolling.

## Test Scenarios
| Layer | Scenario | Expected Result |
| :--- | :--- | :--- |
| **1. Database** | Save recording metadata (UUID, audioPath). | Record is persisted in Isar with valid UUID and valid file path. |
| **2. Service** | Audio capture stream throughput. | Mono PCM 16kHz stream is captured without data loss/gaps. |
| **3. State** | Transition: `Idle -> Recording -> Paused -> Saving`. | State updates correctly; listeners (UI) are notified. |
| **4. UI** | Waveform & Transcript Sync. | Waveform animates in sync with mic input; transcript scrolls automatically. |
