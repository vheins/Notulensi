import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import '../../../core/security/secure_storage_service.dart';
import '../services/biometric_service.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}
class AuthChecking extends AuthState {
  const AuthChecking();
}
class Authenticated extends AuthState {
  const Authenticated();
}
class Unauthenticated extends AuthState {
  final String? error;
  const Unauthenticated({this.error});

  @override
  List<Object?> get props => [error];
}
class AuthBiometricUnavailable extends AuthState {
  const AuthBiometricUnavailable();
}

class AuthController extends GetxController {
  final BiometricService _biometricService;
  final SecureStorageService _secureStorageService;

  AuthController({
    required BiometricService biometricService,
    required SecureStorageService secureStorageService,
  })  : _biometricService = biometricService,
        _secureStorageService = secureStorageService;

  final _state = Rx<AuthState>(const AuthInitial());
  AuthState get state => _state.value;
  Rx<AuthState> get rxState => _state;

  Future<void> checkBiometricAvailability() async {
    _state.value = const AuthChecking();
    final isAvailable = await _biometricService.isBiometricAvailable();
    if (isAvailable) {
      final isSafeBoxEnabled = await _secureStorageService.isSafeBoxEnabled();
      if (isSafeBoxEnabled) {
        await autoAuthenticate();
      } else {
        _state.value = const Unauthenticated();
      }
    } else {
      _state.value = const AuthBiometricUnavailable();
    }
  }

  Future<void> autoAuthenticate() async {
    _state.value = const AuthChecking();
    final success = await _biometricService.authenticate();
    if (success) {
      _state.value = const Authenticated();
    } else {
      _state.value = const Unauthenticated(error: 'Authentication failed or canceled');
    }
  }

  Future<void> authenticate() async {
    print('DEBUG: AuthController.authenticate() called');
    _state.value = const AuthChecking();
    final success = await _biometricService.authenticate();
    print('DEBUG: AuthController authentication success: $success');
    if (success) {
      _state.value = const Authenticated();
    } else {
      _state.value = const Unauthenticated(error: 'Authentication failed or canceled');
    }
  }

  Future<void> toggleSafeBox(bool enabled) async {
    await _secureStorageService.setSafeBoxEnabled(enabled);
    if (enabled) {
      lock();
    }
  }

  void lock() {
    _state.value = const Unauthenticated();
  }
}
