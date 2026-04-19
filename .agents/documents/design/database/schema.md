# Database Schema (Isar): Notulensi

Notulensi uses **Isar Database** for high-performance, offline data persistence.

## 1. MeetingNoteCollection
Stores the main meeting data using UUID primary keys.

```dart
@collection
class MeetingNoteCollection {
  late String id; // UUID String-based Primary Key
  
  @Index(type: IndexType.value)
  late String title;
  
  late DateTime createdAt;
  late DateTime updatedAt;
  DateTime? deletedAt; // Soft Delete support

  @Index(type: IndexType.value, caseSensitive: false)
  late String transcript; // Full-text search enabled

  late String audioPath;
  late int storageSize;

  // Links to associated collections
  final actionItems = IsarLinks<ActionItemCollection>();
  final deadlines = IsarLinks<DeadlineCollection>();
}
```

## 2. ActionItemCollection
Stores extracted action items.

```dart
@collection
class ActionItemCollection {
  late String id; // UUID String-based Primary Key
  
  late String content;
  late int startIndex;
  late int endIndex;
  bool isCompleted = false;
  
  late DateTime createdAt;
  late DateTime updatedAt;

  // Backlink to Note
  @Backlink(to: 'actionItems')
  final note = IsarLink<MeetingNoteCollection>();
}
```

## 3. DeadlineCollection
Stores extracted deadlines.

```dart
@collection
class DeadlineCollection {
  late String id; // UUID String-based Primary Key
  
  late String content;
  late String dateText;
  late DateTime deadlineDate;
  late int startIndex;
  late int endIndex;
  
  late DateTime createdAt;
  late DateTime updatedAt;

  // Backlink to Note
  @Backlink(to: 'deadlines')
  final note = IsarLink<MeetingNoteCollection>();
}
```

## 4. Database Indices & Performance
- **Full-Text Search**: The `transcript` field in `MeetingNoteCollection` is indexed for fast local search.
- **Synchronous vs Asynchronous**:
  - Writes (Saving a note) will be **Asynchronous** to avoid blocking the UI.
  - Reads (Listing notes) will use **Watchers** for real-time UI updates.
- **Relational Integrity**: Links are used to ensure that when a `MeetingNote` is fetched, its associated `ActionItems` and `Deadlines` can be loaded efficiently.
