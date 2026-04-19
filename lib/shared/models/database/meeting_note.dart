import 'package:isar/isar.dart';

part 'meeting_note.g.dart';

@collection
class MeetingNote {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  String title = '';

  String transcript = '';

  String? audioPath;

  int durationSeconds = 0;

  @Index()
  DateTime createdAt = DateTime.now();

  String? folderId;

  @Index(type: IndexType.value)
  List<String> tags = [];
}

@collection
class Folder {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  String name = '';

  String? description;
}
