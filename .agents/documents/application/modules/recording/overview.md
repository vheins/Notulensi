# Module: feature_recording

## Responsibility
The `feature_recording` module manages the audio capture process and coordinates with the STT engine for real-time transcription.

## Architecture
- **Layer**: Presentation & Data.
- **Logic**: `RecordingCubit` for state management; `AudioRepository` for hardware interaction.
- **Plugin**: `record` (Audio) & `speech_to_text` (Transcription).
