import 'dart:async';

class NoiseSuppressionService {
  /// Stub for offline noise suppression.
  Future<String> suppressNoise(String inputPath) async {
    // FFmpeg dependency currently disabled for stable APK build.
    // Returning original path.
    return inputPath;
  }
}
