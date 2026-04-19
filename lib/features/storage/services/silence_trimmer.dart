import 'dart:async';

class SilenceTrimmer {
  /// Stub for trimming silence from audio files.
  Future<String> trimSilence(String inputPath) async {
    // FFmpeg dependency currently disabled for stable APK build.
    // Returning original path.
    return inputPath;
  }
}
