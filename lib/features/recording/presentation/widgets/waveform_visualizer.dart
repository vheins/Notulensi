import 'dart:math';
import 'package:flutter/material.dart';

class WaveformVisualizer extends StatefulWidget {
  final List<double> amplitudes;
  final Color color;

  const WaveformVisualizer({
    super.key,
    required this.amplitudes,
    required this.color,
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

  WaveformPainter({
    required this.amplitudes,
    required this.color,
    required this.animationValue,
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
    
    // Draw from the right (latest)
    final recentAmplitudes = amplitudes.length > maxBars 
        ? amplitudes.sublist(amplitudes.length - maxBars) 
        : amplitudes;

    for (var i = 0; i < recentAmplitudes.length; i++) {
      final x = size.width - (i * spacing) - width;
      final amplitude = recentAmplitudes[recentAmplitudes.length - 1 - i];
      
      // Dynamic height with slight animation jitter
      final h = max(4.0, amplitude * size.height * (0.8 + 0.2 * animationValue));
      
      canvas.drawLine(
        Offset(x, (size.height - h) / 2),
        Offset(x, (size.height + h) / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant WaveformPainter oldDelegate) {
    return oldDelegate.amplitudes != amplitudes || oldDelegate.animationValue != animationValue;
  }
}
