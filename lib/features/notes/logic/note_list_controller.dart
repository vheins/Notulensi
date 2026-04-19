import 'package:get/get.dart';
import 'package:isar/isar.dart';
import '../../../../core/database/isar_service.dart';
import '../../../../shared/models/database/meeting_note.dart';
import '../services/search_service.dart';

class NoteListController extends GetxController {
  final IsarService _isarService;
  final SearchService _searchService;

  NoteListController({
    required IsarService isarService,
    required SearchService searchService,
  })  : _isarService = isarService,
        _searchService = searchService;

  final notes = <MeetingNote>[].obs;
  final isLoading = false.obs;
  final searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Re-bind stream whenever search query changes
    ever(searchQuery, (_) => fetchNotes());
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    isLoading.value = true;
    try {
      final notesStream = _searchService.searchNotes(searchQuery.value);
      notes.bindStream(notesStream);
    } catch (e) {
      // Handle error
    } finally {
      isLoading.value = false;
    }
  }

  void updateSearch(String query) {
    searchQuery.value = query;
  }

  Future<void> deleteNote(Id id) async {
    await _isarService.instance.writeTxn(() async {
      await _isarService.instance.meetingNotes.delete(id);
    });
  }
}
