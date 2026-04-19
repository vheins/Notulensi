import 'package:get/get.dart';
import '../../features/intelligence/services/extraction_service.dart';
import '../../features/notes/logic/note_list_controller.dart';
import '../../features/notes/logic/note_detail_controller.dart';
import '../../features/notes/services/note_management_service.dart';
import '../../features/notes/services/search_service.dart';
import '../../features/recording/logic/audio_playback_controller.dart';
import '../../features/recording/services/audio_player_service.dart';
import '../../features/security/logic/auth_controller.dart';
import '../../features/security/services/biometric_service.dart';
import '../database/isar_service.dart';
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
    Get.lazyPut<SearchService>(() => SearchService(isarService: Get.find<IsarService>()));
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
    Get.lazyPut<AudioPlaybackController>(
      () => AudioPlaybackController(service: Get.find<AudioPlayerService>()),
    );
  }
}
