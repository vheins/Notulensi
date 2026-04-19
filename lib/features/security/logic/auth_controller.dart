import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
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

  AuthController({required BiometricService biometricService})
      : _biometricService = biometricService;

  final _state = Rx<AuthState>(const AuthInitial());
  AuthState get state => _state.value;

  Future<void> checkBiometricAvailability() async {
    _state.value = const AuthChecking();
    final isAvailable = await _biometricService.isBiometricAvailable();
    if (isAvailable) {
      _state.value = const Unauthenticated();
    } else {
      _state.value = const AuthBiometricUnavailable();
    }
  }

  Future<void> authenticate() async {
    _state.value = const AuthChecking();
    final success = await _biometricService.authenticate();
    if (success) {
      _state.value = const Authenticated();
    } else {
      _state.value = const Unauthenticated(error: 'Authentication failed or canceled');
    }
  }

  void lock() {
    _state.value = const Unauthenticated();
  }
}
