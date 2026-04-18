# Database Schema (Isar): Notulensi

Notulensi uses **Isar Database** for high-performance, offline data persistence.

## 1. MeetingNoteCollection
Stores the main meeting data.

```dart
@collection
class MeetingNoteCollection {
  Id id; // Integer ID mapped from UUID String via fastHash

  @Index(type: IndexType.value)
  late String title;

  late DateTime createdAt;

  @Index(type: IndexType.value, caseSensitive: false)
  late String transcript; // Full-text search enabled

  late String audioPath;
  late int storageSize;

  // Backlinks to linked collections
  final actionItems = IsarLinks<ActionItemCollection>();
  final deadlines = IsarLinks<DeadlineCollection>();
}
```

## 2. ActionItemCollection
Stores extracted action items.

```dart
@collection
class ActionItemCollection {
  Id id; // Integer ID mapped from UUID String via fastHash

  late String content;
  late bool isCompleted;

  final note = IsarLink<MeetingNoteCollection>();
}
```

## 3. DeadlineCollection
Stores extracted deadlines.

```dart
@collection
class DeadlineCollection {
  Id id; // Integer ID mapped from UUID String via fastHash

  late String dateText;
  late String associatedText;

  final note = IsarLink<MeetingNoteCollection>();
}
```

## 4. Database Indices & Performance
- **Full-Text Search**: The `transcript` field in `MeetingNoteCollection` is indexed for fast local search.
- **Synchronous vs Asynchronous**:
  - Writes (Saving a note) will be **Asynchronous** to avoid blocking the UI.
  - Reads (Listing notes) will use **Watchers** for real-time UI updates.
- **Relational Integrity**: Links are used to ensure that when a `MeetingNote` is fetched, its associated `ActionItems` and `Deadlines` can be loaded efficiently.
