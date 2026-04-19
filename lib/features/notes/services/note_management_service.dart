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

    await _isarService.instance.writeTxn(() async {
      await _isarService.instance.meetingNotes.delete(id);
    });
  }

  /// Creates a new note with audio path support.
  /// Returns the ID of the created note.
  Future<int> createNoteWithAudio({
    required String title,
    required String transcript,
    required int duration,
    String? audioPath,
  }) async {
    final note = MeetingNote()
      ..title = title
      ..transcript = transcript
      ..durationSeconds = duration
      ..audioPath = audioPath
      ..createdAt = DateTime.now()
      ..tags = [];

    int noteId = 0;
    await _isarService.instance.writeTxn(() async {
      noteId = await _isarService.instance.meetingNotes.put(note);
    });
    return noteId;
  }

  /// Deprecated: use createNoteWithAudio
  Future<void> createNote(String title, String transcript, {int duration = 0}) async {
    await createNoteWithAudio(
      title: title,
      transcript: transcript,
      duration: duration,
    );
  }
}
