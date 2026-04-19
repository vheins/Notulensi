# Testing: Processing

## Test Architecture (4-Concern Rule)
This module adheres to the mandatory 4-concern test strategy:
- **Database Testing**: Ensure extraction updates correct references in `ActionItemCollection` and `DeadlineCollection`.
- **Service Testing**: Test extraction logic functions via isolate entry points for varied inputs (Regex Engine accuracy).
- **State Management Testing**: Test logic for updating UI indicating processing completion (`Processing` vs `Ready`).
- **UI Testing**: Widget test displaying extracted action items and deadlines within note detail views, including highlight toggling.

## Test Scenarios
| Layer | Scenario | Expected Result |
| :--- | :--- | :--- |
| **1. Database** | IsarLinks creation for extracted items. | ActionItem and Deadline records are linked correctly to the parent Note. |
| **2. Service** | Regex extraction accuracy (Regex Engine). | Correctly extracts "call client" from "I will call client tomorrow". |
| **3. State** | Processing isolation (`Processing` vs `Ready`). | UI shows "Processing..." during isolate execution; toggles to "Ready" on completion. |
| **4. UI** | Highlight toggling and highlighting. | Tapping an extracted item scrolls the transcript to the matched position. |
