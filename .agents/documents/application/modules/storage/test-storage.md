# Testing: Storage

## Test Architecture
This module adheres to the mandatory 4-concern test strategy:
- **Database Testing**: Verify CRUD operations, transactions, and cascading deletes on `MeetingNoteCollection`, `ActionItemCollection`, and `DeadlineCollection`.
- **Service Testing**: Test filesystem operations (audio file naming, deletion) and repository abstractions.
- **State Management Testing**: Test cubits/blocs that interface with storage to ensure they emit correct loading, loaded, and error states based on storage operations.
- **UI Testing**: Widget tests that verify UI components react correctly to local data availability (e.g., empty states, populated lists).

## Test Scenarios
| Type | Scenario | Expected Result |
| :--- | :--- | :--- |
| **Positive** | Create and retrieve a note. | Note is persisted and exactly matches input. |
| **Negative** | Save with missing audio file path. | Error is thrown; no DB record is created. |
| **Edge** | Delete note with 500MB audio file. | Record and file are successfully purged without lag. |
| **Security** | Access files outside app sandbox. | OS-level permissions prevent unauthorized access. |
