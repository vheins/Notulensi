# Testing: Processing

## Test Architecture
This module adheres to the mandatory 4-concern test strategy:
- **Database Testing**: Ensure extraction updates correct references in `ActionItemCollection` and `DeadlineCollection`.
- **Service Testing**: Test extraction logic functions via isolate entry points for varied inputs.
- **State Management Testing**: Test logic for updating UI indicating processing completion.
- **UI Testing**: Widget test displaying extracted action items and deadlines within note detail views.

## Test Scenarios
| Type | Scenario | Expected Result |
| :--- | :--- | :--- |
| **Positive** | Transcript: "I will call the client tomorrow." | Extracted: AI="call the client", DL="tomorrow". |
| **Negative** | Empty transcript input. | Engine returns empty lists gracefully. |
| **Edge** | Transcript > 50,000 words. | Background isolate processes without UI jank. |
| **Security** | Sanitization of special characters. | Regex handles symbols without crashing or exploitation. |
