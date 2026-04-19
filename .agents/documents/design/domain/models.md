# Domain Models: Notulensi

The domain layer defines the core entities used throughout the application. These are pure Dart classes.

## 1. MeetingNote
The primary entity representing a single recording session.

```dart
class MeetingNote {
  final String id;
  final String title;
  final DateTime createdAt;
  final String transcript;
  final String audioFilePath;
  final int storageSizeInBytes;
  final bool isEncrypted;
  
  // Associations
  final List<ActionItem> actionItems;
  final List<Deadline> deadlines;
  final List<Marker> markers;
  final List<NotePhoto> photos;
  final List<NoteVersion> history;

  MeetingNote({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.transcript,
    required this.audioFilePath,
    required this.storageSizeInBytes,
    this.isEncrypted = false,
    this.actionItems = const [],
    this.deadlines = const [],
    this.markers = const [],
    this.photos = const [],
    this.history = const [],
  });
}
```

## 2. Marker
A user-defined bookmark anchored to a specific time.

```dart
class Marker {
  final String id;
  final int timestampMs;
  final String label;

  Marker({
    required this.id,
    required this.timestampMs,
    this.label = "Bookmark",
  });
}
```

## 3. NotePhoto
A photo captured during a meeting.

```dart
class NotePhoto {
  final String id;
  final String localPath;
  final int timestampMs;

  NotePhoto({
    required this.id,
    required this.localPath,
    required this.timestampMs,
  });
}
```

## 4. NoteVersion
A historical version of a transcript edit.

```dart
class NoteVersion {
  final String id;
  final String transcript;
  final DateTime savedAt;

  NoteVersion({
    required this.id,
    required this.transcript,
    required this.savedAt,
  });
}
```

## 5. StorageStats
Includes optimizations from the silence trimmer.

```dart
class StorageStats {
  final int totalNotes;
  final int totalBytesUsed;
  final int bytesSavedByTrimming;
  final double availableSpaceGB;

  StorageStats({
    required this.totalNotes,
    required this.totalBytesUsed,
    required this.bytesSavedByTrimming,
    required this.availableSpaceGB,
  });
}
```
