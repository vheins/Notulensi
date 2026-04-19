import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../../../core/theme/notulensi_theme.dart';
import '../../../recording/logic/audio_playback_controller.dart';

class AudioPlayerWidget extends GetView<AudioPlaybackController> {
  final String audioPath;

  const AudioPlayerWidget({
    super.key,
    required this.audioPath,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<NotulensiColors>()!;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.primary.withAlpha(20)),
      ),
      child: Column(
        children: [
          Obx(() {
            final position = controller.position.value;
            final duration = controller.duration.value;

            return Column(
              children: [
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: colors.primary,
                    inactiveTrackColor: colors.primary.withAlpha(30),
                    thumbColor: colors.primary,
                    overlayColor: colors.primary.withAlpha(30),
                    trackHeight: 4,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                  ),
                  child: Slider(
                    min: 0.0,
                    max: duration.inMilliseconds.toDouble(),
                    value: position.inMilliseconds.toDouble().clamp(0.0, duration.inMilliseconds.toDouble()),
                    onChanged: (value) {
                      controller.seek(Duration(milliseconds: value.toInt()));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDuration(position),
                        style: TextStyle(color: colors.textLow, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _formatDuration(duration),
                        style: TextStyle(color: colors.textLow, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.replay_10_rounded),
                color: colors.textHigh,
                onPressed: () {
                  final newPos = controller.position.value - const Duration(seconds: 10);
                  controller.seek(newPos < Duration.zero ? Duration.zero : newPos);
                },
              ),
              const SizedBox(width: 16),
              Obx(() {
                final isPlaying = controller.playerState.value == PlayerState.playing;
                return CircleAvatar(
                  radius: 28,
                  backgroundColor: colors.primary,
                  child: IconButton(
                    iconSize: 32,
                    icon: Icon(
                      isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (controller.playerState.value == PlayerState.stopped || 
                          controller.playerState.value == PlayerState.completed) {
                        controller.play(audioPath);
                      } else {
                        controller.togglePlayback();
                      }
                    },
                  ),
                );
              }),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.forward_10_rounded),
                color: colors.textHigh,
                onPressed: () {
                  final newPos = controller.position.value + const Duration(seconds: 10);
                  controller.seek(newPos > controller.duration.value ? controller.duration.value : newPos);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
