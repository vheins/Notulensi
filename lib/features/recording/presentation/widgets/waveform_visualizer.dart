import 'dart:math';
import 'package:flutter/material.dart';

class WaveformMarker {
  final Duration timestamp;
  final String? label;

  WaveformMarker({required this.timestamp, this.label});
}

class WaveformVisualizer extends StatefulWidget {
  final List<double> amplitudes;
  final Color color;
  final List<WaveformMarker> markers;

  const WaveformVisualizer({
    super.key,
    required this.amplitudes,
    required this.color,
    this.markers = const [],
  });

  @override
  State<WaveformVisualizer> createState() => _WaveformVisualizerState();
}

class _WaveformVisualizerState extends State<WaveformVisualizer> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return CustomPaint(
          size: const Size(double.infinity, 100),
          painter: WaveformPainter(
            amplitudes: widget.amplitudes,
            color: widget.color,
            animationValue: _animationController.value,
            markers: widget.markers,
            totalDuration: Duration.zero,
          ),
        );
      },
    );
  }
}

class WaveformPainter extends CustomPainter {
  final List<double> amplitudes;
  final Color color;
  final double animationValue;
  final List<WaveformMarker> markers;
  final Duration totalDuration;

  WaveformPainter({
    required this.amplitudes,
    required this.color,
    required this.animationValue,
    required this.markers,
    required this.totalDuration,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    const spacing = 6.0;
    const width = 3.0;
    final maxBars = (size.width / spacing).floor();

    final recentAmplitudes = amplitudes.length > maxBars
        ? amplitudes.sublist(amplitudes.length - maxBars)
        : amplitudes;

    for (var i = 0; i < recentAmplitudes.length; i++) {
      final x = size.width - (i * spacing) - width;
      final amplitude = recentAmplitudes[recentAmplitudes.length - 1 - i];

      final h = max(4.0, amplitude * size.height * (0.8 + 0.2 * animationValue));

      canvas.drawLine(
        Offset(x, (size.height - h) / 2),
        Offset(x, (size.height + h) / 2),
        paint,
      );
    }

    for (final marker in markers) {
      if (totalDuration.inSeconds > 0) {
        final position = marker.timestamp.inSeconds / totalDuration.inSeconds;
        final markerX = size.width * (1 - position);

        final markerPaint = Paint()
          ..color = Colors.amber
          ..strokeWidth = 2.0;

        canvas.drawLine(
          Offset(markerX, 0),
          Offset(markerX, size.height),
          markerPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant WaveformPainter oldDelegate) {
    return oldDelegate.amplitudes != amplitudes ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.markers != markers;
  }
}
