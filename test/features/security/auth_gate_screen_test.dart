import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notulensi/core/theme/notulensi_theme.dart';
import 'package:notulensi/features/security/logic/auth_controller.dart';
import 'package:notulensi/features/security/presentation/pages/auth_gate_screen.dart';
import 'package:notulensi/features/security/services/biometric_service.dart';

class MockBiometricService extends Mock implements BiometricService {}

void main() {
  late MockBiometricService mockBiometricService;
  late AuthController authController;

  setUp(() {
    mockBiometricService = MockBiometricService();
    authController = AuthController(biometricService: mockBiometricService);
    
    // Default mock behavior
    when(() => mockBiometricService.isBiometricAvailable()).thenAnswer((_) async => true);
    when(() => mockBiometricService.authenticate()).thenAnswer((_) async => true);
  });

  tearDown(() {
    Get.reset();
  });

  Widget createWidgetUnderTest() {
    return GetMaterialApp(
      theme: NotulensiTheme.darkTheme,
      home: const AuthGateScreen(),
      initialBinding: BindingsBuilder(() {
        Get.put<AuthController>(authController);
      }),
    );
  }

  group('AuthGateScreen Widget Tests', () {
    testWidgets('should display OBSIDIAN VAULT text', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();
      expect(find.text('OBSIDIAN VAULT'), findsOneWidget);
    });

    testWidgets('should show unlock button when available', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump(); // Trigger build
      await tester.pump(const Duration(milliseconds: 100)); // Allow post-frame callback
      await tester.pump(); // Re-render Obx
      
      expect(find.text('UNLOCK WITH BIOMETRICS'), findsOneWidget);
    });

    testWidgets('should show error message when biometrics unavailable', (tester) async {
      when(() => mockBiometricService.isBiometricAvailable()).thenAnswer((_) async => false);
      
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump(); // Trigger build
      await tester.pump(const Duration(milliseconds: 100)); // Allow post-frame callback
      await tester.pump(); // Re-render Obx
      
      expect(find.textContaining('not available'), findsOneWidget);
    });
  });
}
