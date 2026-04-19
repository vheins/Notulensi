import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:local_auth/local_auth.dart';
import 'package:notulensi/features/security/services/biometric_service.dart';

class MockLocalAuthentication extends Mock implements LocalAuthentication {}

void main() {
  late MockLocalAuthentication mockAuth;
  late BiometricService biometricService;

  setUp(() {
    mockAuth = MockLocalAuthentication();
    biometricService = BiometricService(auth: mockAuth);
  });

  group('BiometricService', () {
    test('isBiometricAvailable returns true when supported', () async {
      when(() => mockAuth.canCheckBiometrics).thenAnswer((_) async => true);
      when(() => mockAuth.isDeviceSupported()).thenAnswer((_) async => true);

      final result = await biometricService.isBiometricAvailable();

      expect(result, isTrue);
    });

    test('authenticate calls auth.authenticate with correct parameters', () async {
      when(() => mockAuth.authenticate(
        localizedReason: any(named: 'localizedReason'),
        persistAcrossBackgrounding: any(named: 'persistAcrossBackgrounding'),
        biometricOnly: any(named: 'biometricOnly'),
      )).thenAnswer((_) async => true);

      final result = await biometricService.authenticate(reason: 'Test Reason');

      expect(result, isTrue);
      verify(() => mockAuth.authenticate(
        localizedReason: 'Test Reason',
        persistAcrossBackgrounding: true,
        biometricOnly: true,
      )).called(1);
    });

    test('authenticate returns false on error', () async {
      when(() => mockAuth.authenticate(
        localizedReason: any(named: 'localizedReason'),
        persistAcrossBackgrounding: any(named: 'persistAcrossBackgrounding'),
        biometricOnly: any(named: 'biometricOnly'),
      )).thenThrow(Exception('Auth failed'));

      final result = await biometricService.authenticate();

      expect(result, isFalse);
    });
  });
}
