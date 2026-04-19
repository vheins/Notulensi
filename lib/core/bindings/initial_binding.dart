import 'package:get/get.dart';
import '../../features/export/services/text_export_service.dart';
import '../../features/export/services/pdf_template_engine.dart';
import '../../features/intelligence/services/extraction_service.dart';
import '../../features/intelligence/services/stt_status_service.dart';
import '../../features/notes/logic/note_list_controller.dart';
import '../../features/notes/logic/note_detail_controller.dart';
import '../../features/notes/logic/folder_detail_controller.dart';
import '../../features/notes/logic/selection_controller.dart';
import '../../features/notes/services/note_management_service.dart';
import '../../features/notes/services/search_service.dart';
import '../../features/notes/services/folder_service.dart';
import '../../features/notes/services/versioning_service.dart';
import '../../features/recording/logic/audio_playback_controller.dart';
import '../../features/recording/logic/recording_controller.dart';
import '../../features/recording/services/audio_player_service.dart';
import '../../features/recording/services/session_recovery_service.dart';
import '../../features/security/logic/auth_controller.dart';
import '../../features/security/services/biometric_service.dart';
import '../../features/storage/logic/storage_dashboard_controller.dart';
import '../../features/storage/services/silence_trimmer.dart';
import '../../features/storage/services/storage_monitor_service.dart';
import '../ads/ad_service.dart';
import '../database/isar_service.dart';
import '../hardware/volume_button_listener.dart';
import '../permissions/permission_service.dart';
import '../security/secure_storage_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Core Services
    Get.lazyPut<SecureStorageService>(() => SecureStorageService());
    Get.lazyPut<PermissionService>(() => PermissionService());
    Get.lazyPut<BiometricService>(() => BiometricService());
    Get.lazyPut<IsarService>(() => IsarService(), fenix: true);
    Get.lazyPut<AudioPlayerService>(() => AudioPlayerService());
    Get.lazyPut<ExtractionService>(() => ExtractionService());
    Get.lazyPut<SttStatusService>(() => SttStatusService());
    Get.lazyPut<SearchService>(() => SearchService(isarService: Get.find<IsarService>()));
    Get.lazyPut<FolderService>(() => FolderService(isarService: Get.find<IsarService>()));
    Get.lazyPut<VersioningService>(() => VersioningService(isarService: Get.find<IsarService>()));
    Get.lazyPut<TextExportService>(() => TextExportService());
    Get.lazyPut<PdfTemplateEngine>(() => PdfTemplateEngine());
    Get.lazyPut<SilenceTrimmer>(() => SilenceTrimmer());
    Get.lazyPut<SessionRecoveryService>(() => SessionRecoveryService());
    Get.lazyPut<StorageMonitorService>(() => StorageMonitorService());
    Get.lazyPut<VolumeButtonListener>(() => VolumeButtonListener());
    Get.lazyPut<AdService>(() => AdService(secureStorage: Get.find<SecureStorageService>()));
    Get.lazyPut<NoteManagementService>(
      () => NoteManagementService(isarService: Get.find<IsarService>()),
    );

    // Controllers
    Get.lazyPut<AuthController>(
      () => AuthController(biometricService: Get.find<BiometricService>()),
    );
    Get.lazyPut<NoteListController>(
      () => NoteListController(
        isarService: Get.find<IsarService>(),
        searchService: Get.find<SearchService>(),
      ),
    );
    Get.lazyPut<NoteDetailController>(
      () => NoteDetailController(isarService: Get.find<IsarService>()),
    );
    Get.lazyPut<FolderDetailController>(
      () => FolderDetailController(
        isarService: Get.find<IsarService>(),
        folderService: Get.find<FolderService>(),
      ),
    );
    Get.lazyPut<StorageDashboardController>(
      () => StorageDashboardController(isarService: Get.find<IsarService>()),
    );
    Get.lazyPut<SelectionController>(() => SelectionController());
    Get.lazyPut<AudioPlaybackController>(
      () => AudioPlaybackController(service: Get.find<AudioPlayerService>()),
    );
    Get.lazyPut<RecordingController>(() => RecordingController());
  }
}
