# Database Schema (Isar): Notulensi

Notulensi uses **Isar Database** for high-performance, offline data persistence.

## 1. ProjectFolderCollection
Used to group meeting notes.

```dart
@collection
class ProjectFolderCollection {
  late String id; // UUID
  
  @Index(unique: true)
  late String name;
  
  late DateTime createdAt;
  
  // Link to notes in this folder
  @Backlink(to: 'folder')
  final notes = IsarLinks<MeetingNoteCollection>();
}
```

## 2. MeetingNoteCollection
Stores the main meeting data. Supports encryption and versioning.

```dart
@collection
class MeetingNoteCollection {
  late String id; // UUID
  
  @Index(type: IndexType.value)
  late String title;
  
  late DateTime createdAt;
  late DateTime updatedAt;
  DateTime? deletedAt;

  @Index(type: IndexType.value, caseSensitive: false)
  late String transcript;

  late String audioPath;
  late int storageSize;
  
  // Security
  bool isEncrypted = false;
  String? encryptionSalt; // For Isar encryption key derivation

  // Links
  final folder = IsarLink<ProjectFolderCollection>();
  final actionItems = IsarLinks<ActionItemCollection>();
  final deadlines = IsarLinks<DeadlineCollection>();
  final markers = IsarLinks<MarkerCollection>();
  final photos = IsarLinks<PhotoCollection>();
  final versions = IsarLinks<NoteVersionCollection>();
}
```

## 3. MarkerCollection
User-defined bookmarks during recording.

```dart
@collection
class MarkerCollection {
  late String id; // UUID
  late int timestampMs; // Milliseconds from start of recording
  String? label; // e.g. "Important", "Star"
  
  @Backlink(to: 'markers')
  final note = IsarLink<MeetingNoteCollection>();
}
```

## 4. PhotoCollection
Photos taken during a meeting, anchored to time.

```dart
@collection
class PhotoCollection {
  late String id; // UUID
  late String localPath;
  late int timestampMs;
  
  @Backlink(to: 'photos')
  final note = IsarLink<MeetingNoteCollection>();
}
```

## 5. NoteVersionCollection
Snapshot of transcript history for manual edits.

```dart
@collection
class NoteVersionCollection {
  late String id; // UUID
  late String transcriptSnapshot;
  late DateTime savedAt;
  
  @Backlink(to: 'versions')
  final note = IsarLink<MeetingNoteCollection>();
}
```

## 6. ActionItem & Deadline (Unchanged Structure)
*Refer to previous schema for ActionItemCollection and DeadlineCollection.*

## 7. Performance & Security
- **Isar Encryption**: Sensitive notes are stored using Isar's built-in AES encryption, with keys managed via Biometric/KeyStore.
- **Lazy Loading**: Photos and Versions are loaded only when requested.
- **Indices**: Added indexes for `title`, `transcript`, and `folder.name`.
