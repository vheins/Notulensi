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
  final List<ActionItem> actionItems;
  final List<Deadline> deadlines;

  MeetingNote({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.transcript,
    required this.audioFilePath,
    required this.storageSizeInBytes,
    this.actionItems = const [],
    this.deadlines = const [],
  });
}
```

## 2. ActionItem
A specific task extracted from the transcript.

```dart
class ActionItem {
  final String id;
  final String content;
  final bool isCompleted;

  ActionItem({
    required this.id,
    required this.content,
    this.isCompleted = false,
  });
}
```

## 3. Deadline
A time-sensitive highlight extracted from the transcript.

```dart
class Deadline {
  final String id;
  final String dateText;
  final String associatedText;

  Deadline({
    required this.id,
    required this.dateText,
    required this.associatedText,
  });
}
```

## 4. StorageStats
Used for the Settings screen to display usage.

```dart
class StorageStats {
  final int totalNotes;
  final int totalBytesUsed;
  final double availableSpaceGB;

  StorageStats({
    required this.totalNotes,
    required this.totalBytesUsed,
    required this.availableSpaceGB,
  });
}
```
