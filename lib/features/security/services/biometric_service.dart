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
    print('DEBUG: Biometric availability: $canAuthenticate (canCheck: $canAuthenticateWithBiometrics)');
    return canAuthenticate;
  }

  /// Triggers the system biometric prompt.
  Future<bool> authenticate({String reason = 'Please authenticate to access your notes'}) async {
    print('DEBUG: Starting authentication prompt...');
    try {
      final result = await _auth.authenticate(
        localizedReason: reason,
        persistAcrossBackgrounding: true,
        biometricOnly: true,
      );
      print('DEBUG: Authentication result: $result');
      return result;
    } catch (e) {
      print('DEBUG: Authentication error: $e');
      return false;
    }
  }

  /// Returns the list of available biometric types (fingerprint, face, etc).
  Future<List<BiometricType>> getAvailableBiometrics() async {
    return await _auth.getAvailableBiometrics();
  }
}
