# Testing: Intelligence Engine

## 1. Overview
Verifies the accuracy and performance of the local transcription and rule-based extraction pipeline.

## 2. Test Scenarios

### Positive Scenarios
- **Real-time Stream**: Verify words appear in the stream within <500ms of audio input.
- **Action Item Extraction**: input "Action: send the file" -> verify `ActionItem(description: "send the file")` is created.
- **Deadline Extraction**: input "Finish by Friday" -> verify a `Deadline` object is created with the next Friday's date.
- **PII Redaction**: input "Email me at user@example.com" -> verify result is "Email me at [REDACTED]".

### Negative Scenarios
- **Mic Permission Denied**: Ensure `IntelligenceService` returns a descriptive error state.
- **Empty Transcript**: Ensure processing returns empty lists rather than crashing.
- **No Keywords**: Verify text without "To do" or "Action" results in 0 Action Items.

### Edge/Security Cases
- **Isolate Termination**: Verify that if the parsing isolate is killed, the app retries on the next open.
- **Massive Transcript**: Test processing speed for a 2-hour meeting transcript (>20,000 words).
