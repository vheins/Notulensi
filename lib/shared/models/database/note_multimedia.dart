import 'package:isar/isar.dart';

part 'note_multimedia.g.dart';

@collection
class NoteMultimedia {
  Id id = Isar.autoIncrement;

  @Index()
  late int noteId;

  late String filePath;

  late int timestampMs;

  late String type; // 'PHOTO'

  @Index()
  late DateTime createdAt;
}
