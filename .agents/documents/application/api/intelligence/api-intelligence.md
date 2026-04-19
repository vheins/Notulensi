# API: Core Intelligence Engine

## 1. Overview
Provides programmatic access to the STT stream and post-recording information extraction services.

## 2. Endpoints (Internal Services)

### `IntelligenceService.listenToMic()`
- **Type**: Stream<String>
- **Description**: Subscribes to the real-time transcription from the microphone.
- **Validation**: Requires `Permission.microphone.isGranted`.
- **Throws**: `MicInUseException`, `SttModelNotLoadedException`.

### `IntelligenceService.processTranscript(String rawText)`
- **Type**: Future<NotePayload>
- **Description**: Parses the raw transcript for action items, deadlines, and PII.
- **Params**:
  - `rawText`: The complete transcript string.
- **Return**: A payload containing Lists of ActionItem, Deadline, and the Redacted Transcript.

## 3. Data Validation
- `rawText` must not be empty.
- PII Redaction uses the `EmailRegex` and `PhoneRegex` constants.
- Action items are extracted if a sentence starts with "Must", "To do", or "Action".
