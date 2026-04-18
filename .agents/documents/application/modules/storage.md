# Module Documentation: core_storage

## 1. Responsibility
The `core_storage` module is responsible for the persistent storage and retrieval of all application data, including database records (Isar) and physical files (audio, exported PDFs).

## 2. Architecture
- **Layer**: Data/Infrastructure.
- **Engine**: Isar NoSQL Database.
- **Pattern**: Repository Pattern with Local Data Sources.

## 3. Key Entities (Isar Collections)
- **MeetingNoteCollection**: Primary record for sessions.
- **ActionItemCollection**: Linked tasks.
- **DeadlineCollection**: Linked time-markers.

## 4. Workflows
- **Save Session**: Atomic operation involving audio file naming and Isar record creation.
- **Full-Text Search**: Optimized query using Isar's native indexing.
- **Clean Deletion**: Cascading delete ensuring that when a note record is removed, its associated audio file is also purged from the filesystem.

## 5. Test Scenarios
| Type | Scenario | Expected Result |
| :--- | :--- | :--- |
| **Positive** | Create and retrieve a note. | Note is persisted and exactly matches input. |
| **Negative** | Save with missing audio file path. | Error is thrown; no DB record is created. |
| **Edge** | Delete note with 500MB audio file. | Record and file are successfully purged without lag. |
| **Security** | Access files outside app sandbox. | OS-level permissions prevent unauthorized access. |
