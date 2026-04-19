import 'package:permission_handler/permission_handler.dart';

/// Service for managing runtime permissions.
class PermissionService {
  /// Checks the status of a specific permission.
  Future<PermissionStatus> status(Permission permission) async {
    return await permission.status;
  }

  /// Requests a specific permission.
  Future<PermissionStatus> request(Permission permission) async {
    return await permission.request();
  }

  /// Checks if a permission is granted.
  Future<bool> isGranted(Permission permission) async {
    return await permission.isGranted;
  }

  /// Opens the app settings.
  Future<bool> openAppSettings() async {
    return await openAppSettings();
  }

  /// Specifically requests microphone permission.
  Future<bool> requestMicrophone() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  /// Specifically requests camera permission.
  Future<bool> requestCamera() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }
}
