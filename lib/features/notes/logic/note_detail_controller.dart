import 'package:get/get.dart';
import 'package:isar/isar.dart';
import '../../../../core/database/isar_service.dart';
import '../../../../shared/models/database/meeting_note.dart';

class NoteDetailController extends GetxController {
  final IsarService _isarService;

  NoteDetailController({required IsarService isarService}) : _isarService = isarService;

  final note = Rxn<MeetingNote>();
  final isLoading = false.obs;
  final isRedacted = false.obs;

  Future<void> fetchNote(Id id) async {
    isLoading.value = true;
    try {
      final fetchedNote = await _isarService.instance.meetingNotes.get(id);
      if (fetchedNote != null) {
        note.value = fetchedNote;
      } else {
        Get.back();
        Get.snackbar('Error', 'Note not found');
      }
    } catch (e) {
      Get.back();
      Get.snackbar('Error', 'Failed to load note');
    } finally {
      isLoading.value = false;
    }
  }

  void toggleRedaction() {
    isRedacted.toggle();
  }

  Future<void> updateTranscript(String newTranscript) async {
    if (note.value == null) return;
    
    final updatedNote = note.value!..transcript = newTranscript;
    await _isarService.instance.writeTxn(() async {
      await _isarService.instance.meetingNotes.put(updatedNote);
    });
    note.value = updatedNote;
    note.refresh();
  }
}
