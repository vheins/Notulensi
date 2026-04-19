import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import '../services/audio_player_service.dart';

class AudioPlaybackController extends GetxController {
  final AudioPlayerService _service;

  AudioPlaybackController({required AudioPlayerService service}) : _service = service;

  final playerState = PlayerState.stopped.obs;
  final duration = Duration.zero.obs;
  final position = Duration.zero.obs;

  final List<StreamSubscription> _subscriptions = [];

  @override
  void onInit() {
    super.onInit();
    
    _subscriptions.add(_service.onPlayerStateChanged.listen((state) {
      playerState.value = state;
    }));

    _subscriptions.add(_service.onDurationChanged.listen((d) {
      duration.value = d;
    }));

    _subscriptions.add(_service.onPositionChanged.listen((p) {
      position.value = p;
    }));

    _subscriptions.add(_service.onPlayerComplete.listen((_) {
      playerState.value = PlayerState.completed;
      position.value = Duration.zero;
    }));
  }

  Future<void> play(String path) async {
    try {
      await _service.play(path);
    } catch (e) {
      Get.snackbar('Error', 'Could not play audio file');
    }
  }

  Future<void> togglePlayback() async {
    if (playerState.value == PlayerState.playing) {
      await _service.pause();
    } else if (playerState.value == PlayerState.paused) {
      await _service.resume();
    }
  }

  Future<void> seek(Duration newPosition) async {
    await _service.seek(newPosition);
  }

  @override
  void onClose() {
    for (var sub in _subscriptions) {
      sub.cancel();
    }
    _service.stop(); // Stop audio when leaving screen
    super.onClose();
  }
}
