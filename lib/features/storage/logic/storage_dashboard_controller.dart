import 'dart:io';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../core/database/isar_service.dart';
import '../../../../shared/models/database/meeting_note.dart';

class StorageDashboardController extends GetxController {
  final IsarService _isarService;

  StorageDashboardController({required IsarService isarService}) : _isarService = isarService;

  final audioSize = 0.0.obs;
  final dbSize = 0.0.obs;
  final isLoading = true.obs;
  final lowStorageWarning = false.obs;
  static const double lowStorageThresholdMB = 100.0;

  @override
  void onInit() {
    super.onInit();
    calculateUsage();
  }

  Future<void> calculateUsage() async {
    isLoading.value = true;
    try {
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

      final dir = await getApplicationDocumentsDirectory();
      final dbFile = File('${dir.path}/notulensi_vault.isar');
      if (await dbFile.exists()) {
        dbSize.value = (await dbFile.length()) / (1024 * 1024);
      }

      lowStorageWarning.value = (audioSize.value + dbSize.value) < lowStorageThresholdMB;
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteOldRecordings({int daysOld = 30}) async {
    final cutoff = DateTime.now().subtract(Duration(days: daysOld));
    final notes = await _isarService.instance.meetingNotes
        .filter()
        .createdAtLessThan(cutoff)
        .findAll();

    for (final note in notes) {
      if (note.audioPath != null) {
        final file = File(note.audioPath!);
        if (await file.exists()) {
          await file.delete();
        }
      }
      await _isarService.instance.writeTxn(() async {
        await _isarService.instance.meetingNotes.delete(note.id);
      });
    }

    await calculateUsage();
    Get.snackbar('Cleaned Up', 'Deleted ${notes.length} old recordings');
  }
}
