import 'package:isar/isar.dart';
import '../../../core/database/isar_service.dart';
import '../../../shared/models/database/meeting_note.dart';

/// Service for managing Note CRUD operations and file cleanup.
class NoteManagementService {
  final IsarService _isarService;

  NoteManagementService({required IsarService isarService}) : _isarService = isarService;

  /// Updates an existing note.
  Future<void> updateNote(MeetingNote note) async {
    await _isarService.instance.writeTxn(() async {
      await _isarService.instance.meetingNotes.put(note);
    });
  }

  /// Deletes a note and its associated local assets.
  Future<void> deleteNote(Id id) async {
    final note = await _isarService.instance.meetingNotes.get(id);
    if (note == null) return;

    // TODO: When recording path is implemented in MeetingNote model:
    // await _deleteAssociatedFiles(note);

    await _isarService.instance.writeTxn(() async {
      await _isarService.instance.meetingNotes.delete(id);
    });
  }

  /// Helper to delete local audio/image files.
  // ignore: unused_element
  Future<void> _deleteAssociatedFiles(MeetingNote note) async {
    // This will be fleshed out as the recording/camera features add file paths to the model.
    // Example: File(note.audioPath).delete();
  }

  /// Creates a new note (Initial test helper).
  Future<void> createNote(String title, String transcript) async {
    final note = MeetingNote()
      ..title = title
      ..transcript = transcript
      ..createdAt = DateTime.now()
      ..tags = [];
    
    await _isarService.instance.writeTxn(() async {
      await _isarService.instance.meetingNotes.put(note);
    });
  }
}
