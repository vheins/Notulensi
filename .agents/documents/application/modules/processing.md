# Module Documentation: feature_processing

## 1. Responsibility
The `feature_processing` module implements the rule-based intelligence for extracting highlights (Action Items/Deadlines) from raw transcripts.

## 2. Architecture
- **Layer**: Domain/Data.
- **Processing**: Dart Isolates (`compute`) for non-blocking execution.
- **Logic**: Regex Pipeline (Pure Dart).

## 3. Key Patterns
- **Action Item**: `\b(I|we)\s+(will|shall|must|need to)\s+([^.?!]+)`
- **Deadline**: `\b(by|on)\s+(Monday|Tuesday|...|tomorrow)\b`

## 4. Workflows
- **Extraction Trigger**: Fires automatically when a recording stops.
- **Context Parsing**: Identifies sentence boundaries around matched keywords.
- **Storage Update**: Updates the `MeetingNote` record with new links to `ActionItem` and `Deadline` collections.

## 5. Test Scenarios
| Type | Scenario | Expected Result |
| :--- | :--- | :--- |
| **Positive** | Transcript: "I will call the client tomorrow." | Extracted: AI="call the client", DL="tomorrow". |
| **Negative** | Empty transcript input. | Engine returns empty lists gracefully. |
| **Edge** | Transcript > 50,000 words. | Background isolate processes without UI jank. |
| **Security** | Sanitization of special characters. | Regex handles symbols without crashing or exploitation. |
