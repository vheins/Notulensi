import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notulensi/features/security/logic/auth_controller.dart';
import 'package:notulensi/features/security/services/biometric_service.dart';

class MockBiometricService extends Mock implements BiometricService {}

void main() {
  late MockBiometricService mockBiometricService;
  late AuthController authController;

  setUp(() {
    mockBiometricService = MockBiometricService();
    authController = AuthController(biometricService: mockBiometricService);
  });

  group('AuthController', () {
    test('initial state should be AuthInitial', () {
      expect(authController.state, equals(const AuthInitial()));
    });

    test('checkBiometricAvailability sets Unauthenticated when available', () async {
      when(() => mockBiometricService.isBiometricAvailable())
          .thenAnswer((_) async => true);

      await authController.checkBiometricAvailability();
      expect(authController.state, equals(const Unauthenticated()));
    });

    test('checkBiometricAvailability sets AuthBiometricUnavailable when not available', () async {
      when(() => mockBiometricService.isBiometricAvailable())
          .thenAnswer((_) async => false);

      await authController.checkBiometricAvailability();
      expect(authController.state, equals(const AuthBiometricUnavailable()));
    });

    test('authenticate sets Authenticated on success', () async {
      when(() => mockBiometricService.authenticate())
          .thenAnswer((_) async => true);

      await authController.authenticate();
      expect(authController.state, equals(const Authenticated()));
    });

    test('authenticate sets Unauthenticated on failure', () async {
      when(() => mockBiometricService.authenticate())
          .thenAnswer((_) async => false);

      await authController.authenticate();
      expect(authController.state, equals(const Unauthenticated(error: 'Authentication failed or canceled')));
    });

    test('lock sets Unauthenticated', () {
      authController.lock();
      expect(authController.state, equals(const Unauthenticated()));
    });
  });
}
