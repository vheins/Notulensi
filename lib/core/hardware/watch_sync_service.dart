import 'package:watch_connectivity/watch_connectivity.dart';

class WatchSyncService {
  final WatchConnectivity _watch = WatchConnectivity();

  /// Listens for commands from the paired smartwatch (Apple Watch or WearOS).
  void startListening({required Function(String) onCommand}) {
    _watch.messageStream.listen((message) {
      if (message.containsKey('command')) {
        onCommand(message['command'] as String);
      }
    });
  }

  /// Sends state updates to the watch.
  Future<void> updateWatchState(Map<String, dynamic> state) async {
    await _watch.sendMessage(state);
  }

  /// Sends a haptic feedback trigger to the watch.
  Future<void> triggerHaptic() async {
    await _watch.sendMessage({'action': 'HAPTIC'});
  }
}
