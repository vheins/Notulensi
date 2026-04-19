import 'dart:async';
import 'package:perfect_volume_control/perfect_volume_control.dart';

class VolumeButtonListener {
  StreamSubscription<double>? _subscription;
  
  /// Listens for volume changes as a proxy for physical button presses.
  void startListening({required Function() onButtonPressed}) {
    _subscription?.cancel();
    
    // perfect_volume_control reports volume between 0.0 and 1.0
    _subscription = PerfectVolumeControl.stream.listen((volume) {
      onButtonPressed();
    });
  }

  void stopListening() {
    _subscription?.cancel();
    _subscription = null;
  }
}
