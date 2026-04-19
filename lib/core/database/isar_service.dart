import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../shared/models/database/meeting_note.dart';
import '../../shared/models/database/note_version.dart';
import '../../shared/models/database/note_multimedia.dart';

/// Service for managing the Isar database instance.
/// Note: Isar 3.x stable does not support native full-database encryption.
/// Application-level field encryption is used for sensitive data.
class IsarService {
  late Isar _isar;
  Isar get instance => _isar;

  /// Initializes the Isar database.
  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    
    _isar = await Isar.open(
      [MeetingNoteSchema, FolderSchema, NoteVersionSchema, NoteMultimediaSchema],
      directory: dir.path,
      name: 'notulensi_vault',
      inspector: true,
    );
  }

  /// Closes the database instance.
  Future<void> close() async {
    await _isar.close();
  }
}
