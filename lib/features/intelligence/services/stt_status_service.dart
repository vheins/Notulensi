import 'package:speech_to_text/speech_to_text.dart';
import 'package:get/get.dart';

class SttStatusService {
  final SpeechToText _stt = SpeechToText();
  final isModelDownloaded = true.obs; // Mock for baseline status
  
  /// Checks if offline STT is available for the given locale.
  /// Note: This is an estimation based on the 'hasSpeech' initialization 
  /// and available locales metadata.
  Future<bool> isOfflineSttAvailable() async {
    final available = await _stt.initialize();
    if (!available) return false;

    // Check if any locales are available
    final locales = await _stt.locales();
    return locales.isNotEmpty;
  }

  /// Gets the current list of supported locales.
  Future<List<LocaleName>> getAvailableLocales() async {
    await _stt.initialize();
    return await _stt.locales();
  }
}
