# Feature: Recording

## Workflows
- **STT Model Management**: Check STT model status via `speech_to_text`.
  - States: `Not Downloaded`, `Downloading`, `Ready`, `Failed`.
  - State emitted to UI blocks recording unless `Ready`.
- **Start Recording**: Request mic permission -> Initialize STT -> Open audio stream.
- **Live Stream**: Simultaneously pipe audio to filesystem and text engine.
- **Error Handling**: Graceful recovery if mic focus is lost or OS terminates the background task.

## User Stories
- **US-001**: Record audio directly in the app.
- **US-002**: View real-time transcript updates.
