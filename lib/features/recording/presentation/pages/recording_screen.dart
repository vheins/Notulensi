import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notulensi/core/theme/notulensi_theme.dart';
import 'package:notulensi/features/recording/logic/recording_controller.dart';
import 'package:notulensi/features/recording/presentation/widgets/waveform_visualizer.dart';

class RecordingScreen extends GetView<RecordingController> {
  const RecordingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<NotulensiColors>()!;
    
    // Auto-start recording on build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!controller.isRecording.value) {
        controller.startRecording();
      }
    });

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header: Status + Timer
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      _PulseIndicator(color: colors.error),
                      const SizedBox(width: 8),
                      Text(
                        'RECORDING',
                        style: TextStyle(
                          color: colors.textHigh,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Obx(() => Text(
                    _formatDuration(controller.duration.value),
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: colors.textHigh,
                    ),
                  )),
                ],
              ),
            ),

            const Spacer(),

            // Live Transcript Area
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Obx(() => Text(
                controller.transcript.value.isNotEmpty 
                    ? controller.transcript.value 
                    : 'Listening for speech...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.textHigh.withAlpha(200),
                  fontSize: 18,
                  height: 1.5,
                  fontStyle: FontStyle.italic,
                ),
              )),
            ),

            const Spacer(),

            // Waveform
            Container(
              height: 120,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Obx(() => WaveformVisualizer(
                amplitudes: controller.amplitudes.toList(),
                color: colors.primary,
                markers: controller.markers.toList(),
              )),
            ),

            // Controls
            Padding(
              padding: const EdgeInsets.only(bottom: 48),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.star_outline_rounded),
                    color: colors.textLow,
                    iconSize: 32,
                    onPressed: () => controller.addMarker(),
                  ),
                  
                  // Stop Button
                  GestureDetector(
                    onTap: () {
                      print('DEBUG: Stop button pressed');
                      controller.stopAndSave();
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: colors.primary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: colors.primary.withAlpha(100),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.stop_rounded, color: Colors.white, size: 40),
                    ),
                  ),

                  IconButton(
                    icon: const Icon(Icons.camera_alt_outlined),
                    color: colors.textLow,
                    iconSize: 32,
                    onPressed: () {
                      // TODO: Implement camera anchoring
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}

class _PulseIndicator extends StatefulWidget {
  final Color color;
  const _PulseIndicator({required this.color});

  @override
  State<_PulseIndicator> createState() => _PulseIndicatorState();
}

class _PulseIndicatorState extends State<_PulseIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(color: widget.color, shape: BoxShape.circle),
      ),
    );
  }
}
