import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/navigation/app_routes.dart';
import '../../../../core/theme/notulensi_theme.dart';
import '../../logic/auth_controller.dart';

class AuthGateScreen extends GetView<AuthController> {
  const AuthGateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<NotulensiColors>()!;
    
    // Check availability on first build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.checkBiometricAvailability();
      
      // Listen for auth success to navigate
      ever(controller.rxState, (state) {
        if (state is Authenticated) {
          Get.offAllNamed(AppRoutes.home);
        }
      });
    });

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colors.background,
              colors.surface.withAlpha((0.5 * 255).round()),
              colors.background,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 2),
              
              // Obsidian Vault Icon (Glowing)
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: colors.primary.withAlpha((0.3 * 255).round()),
                      blurRadius: 40,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.lock_outline_rounded,
                  size: 80,
                  color: colors.primary,
                ),
              ),
              
              const SizedBox(height: 40),
              
              Text(
                'OBSIDIAN VAULT',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 28,
                  letterSpacing: 4,
                  color: colors.textHigh,
                ),
              ),
              
              const SizedBox(height: 12),
              
              Text(
                'YOUR PRIVATE ARCHIVE',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  letterSpacing: 2,
                  color: colors.textLow,
                ),
              ),
              
              const Spacer(flex: 3),
              
              // Auth Button / State Listener
              Obx(() {
                final state = controller.state;
                
                if (state is AuthBiometricUnavailable) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'Biometric authentication is not available on this device.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: colors.error),
                    ),
                  );
                }

                if (state is Authenticated) {
                  return Icon(Icons.check_circle_outline, color: colors.success, size: 64);
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: ElevatedButton(
                    onPressed: state is AuthChecking ? null : () => controller.authenticate(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.primary,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: state is AuthChecking
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'UNLOCK WITH BIOMETRICS',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                  ),
                );
              }),
              
              const SizedBox(height: 24),
              
              // Footer
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.security, size: 14, color: colors.textLow),
                    const SizedBox(width: 8),
                    Text(
                      '100% OFFLINE | AES-256 ENCRYPTED',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontSize: 10,
                        color: colors.textLow,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
