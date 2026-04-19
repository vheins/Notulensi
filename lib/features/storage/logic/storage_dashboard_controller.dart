import 'dart:io';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../core/database/isar_service.dart';
import '../../../../shared/models/database/meeting_note.dart';

class StorageDashboardController extends GetxController {
  final IsarService _isarService;

  StorageDashboardController({required IsarService isarService}) : _isarService = isarService;

  final audioSize = 0.0.obs; // MB
  final dbSize = 0.0.obs;    // MB
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    calculateUsage();
  }

  Future<void> calculateUsage() async {
    isLoading.value = true;
    try {
      // 1. Audio usage
      final notes = await _isarService.instance.meetingNotes.where().findAll();
      double totalAudioBytes = 0;
      for (final note in notes) {
        if (note.audioPath != null) {
          final file = File(note.audioPath!);
          if (await file.exists()) {
            totalAudioBytes += await file.length();
          }
        }
      }
      audioSize.value = totalAudioBytes / (1024 * 1024);

      // 2. DB usage (estimation)
      final dir = await getApplicationDocumentsDirectory();
      final dbFile = File('${dir.path}/notulensi_vault.isar');
      if (await dbFile.exists()) {
        dbSize.value = (await dbFile.length()) / (1024 * 1024);
      }
    } catch (e) {
      // Handle error
    } finally {
      isLoading.value = false;
    }
  }
}
