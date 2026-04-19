import 'package:isar/isar.dart';
import '../../../core/database/isar_service.dart';
import '../../../shared/models/database/meeting_note.dart';

/// Service for performing local full-text search.
class SearchService {
  final IsarService _isarService;

  SearchService({required IsarService isarService}) : _isarService = isarService;

  /// Searches notes by title or transcript.
  Stream<List<MeetingNote>> searchNotes(String query) {
    if (query.isEmpty) {
      return _isarService.instance.meetingNotes
          .where()
          .sortByCreatedAtDesc()
          .watch(fireImmediately: true);
    }

    return _isarService.instance.meetingNotes
        .filter()
        .titleContains(query, caseSensitive: false)
        .or()
        .transcriptContains(query, caseSensitive: false)
        .sortByCreatedAtDesc()
        .watch(fireImmediately: true);
  }
}
