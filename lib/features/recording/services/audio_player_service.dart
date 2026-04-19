import 'package:audioplayers/audioplayers.dart';

/// Service for managing local audio playback.
class AudioPlayerService {
  final AudioPlayer _player = AudioPlayer();

  Stream<Duration> get onPositionChanged => _player.onPositionChanged;
  Stream<Duration> get onDurationChanged => _player.onDurationChanged;
  Stream<PlayerState> get onPlayerStateChanged => _player.onPlayerStateChanged;
  Stream<void> get onPlayerComplete => _player.onPlayerComplete;

  Future<void> play(String path) async {
    await _player.play(DeviceFileSource(path));
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> resume() async {
    await _player.resume();
  }

  Future<void> stop() async {
    await _player.stop();
  }

  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  Future<void> dispose() async {
    await _player.dispose();
  }
}
