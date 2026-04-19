import 'package:get/get.dart';
import '../../features/security/logic/auth_controller.dart';
import '../../features/security/services/biometric_service.dart';
import '../permissions/permission_service.dart';
import '../security/secure_storage_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Core Services
    Get.lazyPut<SecureStorageService>(() => SecureStorageService());
    Get.lazyPut<PermissionService>(() => PermissionService());
    Get.lazyPut<BiometricService>(() => BiometricService());

    // Controllers
    Get.lazyPut<AuthController>(
      () => AuthController(biometricService: Get.find<BiometricService>()),
    );
  }
}
