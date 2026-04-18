# Testing: Export

## Test Architecture
This module adheres to the mandatory 4-concern test strategy:
- **Database Testing**: Verify fetching notes and highlights from Isar for export.
- **Service Testing**: Mock document generation (PDF/TXT) and verify file output structure and content.
- **State Management Testing**: Test state emissions during the generation and sharing process (e.g., preparing, ready, sharing, error).
- **UI Testing**: Widget test for the share/export bottom sheet and error dialogs.

## Test Scenarios
| Type | Scenario | Expected Result |
| :--- | :--- | :--- |
| **Positive** | Export PDF with 10 Action Items. | PDF is generated and contains all items. |
| **Negative** | Export with zero transcript content. | Export blocked; user notified. |
| **Edge** | Rapidly trigger export multiple times. | System queues or replaces temp files without crash. |
| **Security** | Restricted file paths. | System verifies write access before attempting to save. |
