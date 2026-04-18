# Feature: Storage

## Key Entities (Isar Collections)
- **MeetingNoteCollection**: Primary record for sessions.
- **ActionItemCollection**: Linked tasks.
- **DeadlineCollection**: Linked time-markers.

## Workflows
- **Save Session**: Atomic operation involving audio file naming and Isar record creation.
- **Full-Text Search**: Optimized query using Isar's native indexing.
- **Clean Deletion**: Cascading delete ensuring that when a note record is removed, its associated audio file is also purged from the filesystem.
