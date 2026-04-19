import 'package:isar/isar.dart';
import '../../../core/database/isar_service.dart';
import '../../../shared/models/database/meeting_note.dart';
import 'analytics_service.dart';

class ContextLinkingService {
  final IsarService _isarService;
  final AnalyticsService _analyticsService;

  ContextLinkingService({
    required IsarService isarService,
    required AnalyticsService analyticsService,
  })  : _isarService = isarService,
        _analyticsService = analyticsService;

  /// Finds notes related to the current note based on shared high-density keywords.
  Future<List<MeetingNote>> findRelatedNotes(MeetingNote currentNote) async {
    final keywords = _analyticsService.getKeywordDensity(currentNote.transcript).keys.toList();
    if (keywords.isEmpty) return [];

    // Search for other notes containing any of these keywords
    final results = await _isarService.instance.meetingNotes
        .filter()
        .not().idEqualTo(currentNote.id)
        .and()
        .group((q) {
          QueryBuilder<MeetingNote, MeetingNote, QAfterFilterCondition> query = q.transcriptContains(keywords[0], caseSensitive: false);
          for (var i = 1; i < keywords.length; i++) {
            query = query.or().transcriptContains(keywords[i], caseSensitive: false);
          }
          return query;
        })
        .limit(5)
        .findAll();

    return results;
  }
}
