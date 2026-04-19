import 'package:isar/isar.dart';

part 'note_multimedia.g.dart';

@collection
class NoteMultimedia {
  Id id = Isar.autoIncrement;

  @Index()
  int noteId = 0;

  String filePath = '';

  int timestampMs = 0;

  String type = 'PHOTO';

  @Index()
  DateTime createdAt = DateTime.now();
}
