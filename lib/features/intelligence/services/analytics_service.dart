import 'dart:math';

class AnalyticsService {
  /// Calculates words per minute (WPM) based on transcript and duration.
  double calculateWpm(String transcript, Duration duration) {
    if (duration.inSeconds == 0) return 0;
    
    final wordCount = transcript.trim().split(RegExp(r'\s+')).where((s) => s.isNotEmpty).length;
    final minutes = duration.inSeconds / 60.0;
    
    return wordCount / minutes;
  }

  /// Generates a list of data points representing speech speed over time.
  /// This mocks time-series data for the WPM chart.
  List<double> generateWpmSeries(String transcript, Duration totalDuration) {
    final wpm = calculateWpm(transcript, totalDuration);
    final random = Random();
    
    // Create 10 data points with slight variance around the average
    return List.generate(10, (index) {
      final variance = (random.nextDouble() - 0.5) * (wpm * 0.4);
      return max(0, wpm + variance);
    });
  }

  /// Identifies high-density keywords (top 3) in the transcript.
  Map<String, int> getKeywordDensity(String transcript) {
    final words = transcript.toLowerCase()
        .replaceAll(RegExp(r'[^\w\s]'), '')
        .split(RegExp(r'\s+'))
        .where((w) => w.length > 3) // Ignore short filler words
        .toList();

    final Map<String, int> counts = {};
    for (var word in words) {
      counts[word] = (counts[word] ?? 0) + 1;
    }

    final sortedEntries = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Map.fromEntries(sortedEntries.take(3));
  }
}
