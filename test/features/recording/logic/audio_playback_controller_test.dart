import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notulensi/features/recording/logic/audio_playback_controller.dart';
import 'package:notulensi/features/recording/services/audio_player_service.dart';

class MockAudioPlayerService extends Mock implements AudioPlayerService {}

void main() {
  late MockAudioPlayerService mockService;
  late AudioPlaybackController controller;

  setUp(() {
    mockService = MockAudioPlayerService();
    
    // Default mock behavior for streams
    when(() => mockService.onPlayerStateChanged).thenAnswer((_) => const Stream.empty());
    when(() => mockService.onDurationChanged).thenAnswer((_) => const Stream.empty());
    when(() => mockService.onPositionChanged).thenAnswer((_) => const Stream.empty());
    when(() => mockService.onPlayerComplete).thenAnswer((_) => const Stream.empty());
    when(() => mockService.dispose()).thenAnswer((_) async => {});

    controller = AudioPlaybackController(service: mockService);
  });

  group('AudioPlaybackController', () {
    test('initial state should be stopped', () {
      expect(controller.playerState.value, equals(PlayerState.stopped));
      expect(controller.duration.value, equals(Duration.zero));
      expect(controller.position.value, equals(Duration.zero));
    });

    test('play calls service play', () async {
      when(() => mockService.play(any())).thenAnswer((_) async => {});
      
      await controller.play('test_path.wav');
      
      verify(() => mockService.play('test_path.wav')).called(1);
    });

    test('togglePlayback pauses when playing', () async {
      controller.playerState.value = PlayerState.playing;
      when(() => mockService.pause()).thenAnswer((_) async => {});
      
      await controller.togglePlayback();
      
      verify(() => mockService.pause()).called(1);
    });

    test('togglePlayback resumes when paused', () async {
      controller.playerState.value = PlayerState.paused;
      when(() => mockService.resume()).thenAnswer((_) async => {});
      
      await controller.togglePlayback();
      
      verify(() => mockService.resume()).called(1);
    });
  });
}
