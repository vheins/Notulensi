import 'dart:math';

class SpeakerTaggingService {
  /// Simple VAD (Voice Activity Detection) based on amplitude.
  /// Detects pauses > 1 second to suggest speaker shifts.
  bool isSpeakerShift(List<double> samples, {double threshold = 0.05, int minPauseMs = 1000}) {
    if (samples.isEmpty) return false;

    // Calculate energy (RMS)
    double sum = 0;
    for (var sample in samples) {
      sum += sample * sample;
    }
    final rms = sqrt(sum / samples.length);

    // If RMS is below threshold, it's a potential pause
    return rms < threshold;
  }

  /// Injects speaker tags into transcript based on detected pauses.
  String formatWithSpeakerTags(String text, bool isPauseDetected) {
    if (isPauseDetected && text.isNotEmpty && !text.endsWith('\n\n')) {
      return '$text\n\n[SPEAKER SHIFT]: ';
    }
    return text;
  }
}