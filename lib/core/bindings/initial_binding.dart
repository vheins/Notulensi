import 'package:get/get.dart';
import '../../features/notes/logic/note_list_controller.dart';
import '../../features/notes/logic/note_detail_controller.dart';
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
    Get.lazyPut<IsarService>(() => IsarService());

    // Controllers
    Get.lazyPut<AuthController>(
      () => AuthController(biometricService: Get.find<BiometricService>()),
    );
    Get.lazyPut<NoteListController>(
      () => NoteListController(isarService: Get.find<IsarService>()),
    );
    Get.lazyPut<NoteDetailController>(
      () => NoteDetailController(isarService: Get.find<IsarService>()),
    );
  }
}
