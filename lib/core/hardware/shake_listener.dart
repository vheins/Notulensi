import 'package:shake/shake.dart';

class ShakeListener {
  ShakeDetector? _detector;

  /// Starts listening for device shake gestures.
  void startListening({required PhoneShakeCallback onShake}) {
    _detector = ShakeDetector.autoStart(
      onPhoneShake: onShake,
      shakeThresholdGravity: 2.7, // Optimized for quick intentional shakes
      shakeSlopTimeMS: 500,
    );
  }

  /// Stops listening for shake gestures.
  void stopListening() {
    _detector?.stopListening();
  }
}
