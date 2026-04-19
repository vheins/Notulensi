import 'package:isar/isar.dart';

part 'meeting_note.g.dart';

@collection
class MeetingNote {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  late String title;

  late String transcript;

  late String? audioPath;

  late int durationSeconds;

  @Index()
  late DateTime createdAt;

  late String? folderId;

  @Index(type: IndexType.value)
  late List<String> tags;
}

@collection
class Folder {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String name;

  late String? description;
}
