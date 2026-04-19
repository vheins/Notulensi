import 'package:get/get.dart';
import 'package:isar/isar.dart';
import '../../../../core/database/isar_service.dart';
import '../../../../shared/models/database/meeting_note.dart';
import '../services/folder_service.dart';

class FolderDetailController extends GetxController {
  final IsarService _isarService;
  final FolderService _folderService;

  FolderDetailController({
    required IsarService isarService,
    required FolderService folderService,
  })  : _isarService = isarService,
        _folderService = folderService;

  final folder = Rxn<Folder>();
  final notes = <MeetingNote>[].obs;
  final isLoading = false.obs;

  Future<void> fetchFolder(Id id) async {
    isLoading.value = true;
    try {
      final fetchedFolder = await _isarService.instance.folders.get(id);
      if (fetchedFolder != null) {
        folder.value = fetchedFolder;
        _bindNotes(id);
      } else {
        Get.back();
        Get.snackbar('Error', 'Folder not found');
      }
    } catch (e) {
      Get.back();
      Get.snackbar('Error', 'Failed to load folder');
    } finally {
      isLoading.value = false;
    }
  }

  void _bindNotes(Id folderId) {
    final notesStream = _isarService.instance.meetingNotes
        .filter()
        .folderIdEqualTo(folderId.toString())
        .sortByCreatedAtDesc()
        .watch(fireImmediately: true);
    notes.bindStream(notesStream);
  }

  Future<void> updateFolderName(String newName) async {
    if (folder.value == null) return;
    final f = folder.value!..name = newName;
    await _folderService.createFolder(f); // put updates if ID exists
    folder.refresh();
  }

  Future<void> deleteFolder() async {
    if (folder.value == null) return;
    await _folderService.deleteFolder(folder.value!.id);
    Get.back();
  }
}
