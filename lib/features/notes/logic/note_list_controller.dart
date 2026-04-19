import 'dart:async';
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
  StreamSubscription<List<MeetingNote>>? _notesSubscription;

  @override
  void onInit() {
    super.onInit();
    ever(searchQuery, (_) => fetchNotes());
    fetchNotes();
  }

  @override
  void onClose() {
    _notesSubscription?.cancel();
    super.onClose();
  }

  Future<void> fetchNotes() async {
    isLoading.value = true;

    await _notesSubscription?.cancel();

    final notesStream = _searchService.searchNotes(searchQuery.value);
    _notesSubscription = notesStream.listen(
      (noteList) {
        notes.assignAll(noteList);
        isLoading.value = false;
      },
      onError: (e) {
        isLoading.value = false;
      },
    );
  }

  Future<void> refreshNotes() async {
    await fetchNotes();
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
