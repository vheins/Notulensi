import 'package:isar/isar.dart';

part 'note_version.g.dart';

@collection
class NoteVersion {
  Id id = Isar.autoIncrement;

  @Index()
  int noteId = 0;

  String transcript = '';

  @Index()
  DateTime createdAt = DateTime.now();
}
