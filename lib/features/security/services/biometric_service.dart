import 'package:local_auth/local_auth.dart';

/// Service for handling biometric authentication (FaceID, Fingerprint).
class BiometricService {
  final LocalAuthentication _auth;

  BiometricService({LocalAuthentication? auth})
      : _auth = auth ?? LocalAuthentication();

  /// Checks if biometrics are supported and enabled on the device.
  Future<bool> isBiometricAvailable() async {
    final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
    final bool canAuthenticate = canAuthenticateWithBiometrics || await _auth.isDeviceSupported();
    return canAuthenticate;
  }

  /// Triggers the system biometric prompt.
  Future<bool> authenticate({String reason = 'Please authenticate to access your notes'}) async {
    try {
      return await _auth.authenticate(
        localizedReason: reason,
      );
    } catch (e) {
      return false;
    }
  }

  /// Returns the list of available biometric types (fingerprint, face, etc).
  Future<List<BiometricType>> getAvailableBiometrics() async {
    return await _auth.getAvailableBiometrics();
  }
}
