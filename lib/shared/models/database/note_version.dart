import 'package:isar/isar.dart';

part 'note_version.g.dart';

@collection
class NoteVersion {
  Id id = Isar.autoIncrement;

  @Index()
  late int noteId;

  late String transcript;

  @Index()
  late DateTime createdAt;
}
