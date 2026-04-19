class VoiceCommandService {
  /// Simple keyword matcher for real-time STT streams.
  /// This provides basic hands-free control.
  bool processStream(String partialTranscript, {required Function(String) onCommand}) {
    final lower = partialTranscript.toLowerCase();

    if (lower.contains('stop recording')) {
      onCommand('STOP');
      return true;
    }
    
    if (lower.contains('pause recording')) {
      onCommand('PAUSE');
      return true;
    }

    if (lower.contains('mark as highlight') || lower.contains('tandai penting')) {
      onCommand('HIGHLIGHT');
      return true;
    }

    return false;
  }
}
