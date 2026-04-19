import 'package:isar/isar.dart';
import '../../../core/database/isar_service.dart';
import '../../../shared/models/database/note_version.dart';

class VersioningService {
  final IsarService _isarService;

  VersioningService({required IsarService isarService}) : _isarService = isarService;

  /// Saves a new snapshot of the transcript.
  /// Limits to 5 versions per note to save space.
  Future<void> saveSnapshot(int noteId, String transcript) async {
    final newVersion = NoteVersion()
      ..noteId = noteId
      ..transcript = transcript
      ..createdAt = DateTime.now();

    await _isarService.instance.writeTxn(() async {
      await _isarService.instance.noteVersions.put(newVersion);

      // Pruning: Keep only latest 5 versions
      final versions = await _isarService.instance.noteVersions
          .filter()
          .noteIdEqualTo(noteId)
          .sortByCreatedAtDesc()
          .findAll();

      if (versions.length > 5) {
        final toDelete = versions.sublist(5).map((v) => v.id).toList();
        await _isarService.instance.noteVersions.deleteAll(toDelete);
      }
    });
  }

  Future<List<NoteVersion>> getVersions(int noteId) async {
    return await _isarService.instance.noteVersions
        .filter()
        .noteIdEqualTo(noteId)
        .sortByCreatedAtDesc()
        .findAll();
  }
}
