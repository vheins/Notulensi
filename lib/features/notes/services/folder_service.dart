import 'package:isar/isar.dart';
import '../../../core/database/isar_service.dart';
import '../../../shared/models/database/meeting_note.dart';

class FolderService {
  final IsarService _isarService;

  FolderService({required IsarService isarService}) : _isarService = isarService;

  Future<void> createFolder(Folder folder) async {
    await _isarService.instance.writeTxn(() async {
      await _isarService.instance.folders.put(folder);
    });
  }

  Future<List<Folder>> getAllFolders() async {
    return await _isarService.instance.folders.where().findAll();
  }

  Future<void> deleteFolder(Id id) async {
    await _isarService.instance.writeTxn(() async {
      // Logic for orphaned notes: move to default folder (null)
      final notesInFolder = await _isarService.instance.meetingNotes
          .filter()
          .folderIdEqualTo(id.toString())
          .findAll();
          
      for (final note in notesInFolder) {
        note.folderId = null;
        await _isarService.instance.meetingNotes.put(note);
      }
      
      await _isarService.instance.folders.delete(id);
    });
  }

  Future<void> moveNoteToFolder(MeetingNote note, Id? folderId) async {
    await _isarService.instance.writeTxn(() async {
      note.folderId = folderId?.toString();
      await _isarService.instance.meetingNotes.put(note);
    });
  }
}
