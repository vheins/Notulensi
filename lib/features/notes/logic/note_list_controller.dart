import 'package:get/get.dart';
import 'package:isar/isar.dart';
import '../../../../core/database/isar_service.dart';
import '../../../../shared/models/database/meeting_note.dart';

class NoteListController extends GetxController {
  final IsarService _isarService;

  NoteListController({required IsarService isarService}) : _isarService = isarService;

  final notes = <MeetingNote>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    isLoading.value = true;
    try {
      final isar = _isarService.instance;
      // Stream notes for real-time updates
      final notesStream = isar.meetingNotes.where().sortByCreatedAtDesc().watch(fireImmediately: true);
      notes.bindStream(notesStream);
    } catch (e) {
      // Handle error
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteNote(Id id) async {
    await _isarService.instance.writeTxn(() async {
      await _isarService.instance.meetingNotes.delete(id);
    });
  }
}
