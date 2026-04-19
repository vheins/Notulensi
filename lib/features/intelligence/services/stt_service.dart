import 'package:speech_to_text/speech_to_text.dart';
import 'package:get/get.dart';

class SttService extends GetxService {
  final SpeechToText _stt = SpeechToText();
  final isAvailable = false.obs;
  final isListening = false.obs;
  final lastWords = ''.obs;
  final status = ''.obs;
  final error = ''.obs;

  Future<void> init() async {
    try {
      print('DEBUG: Initializing STT...');
      isAvailable.value = await _stt.initialize(
        onStatus: (s) {
          print('DEBUG: STT Status Change: $s');
          status.value = s;
          isListening.value = s == 'listening';
        },
        onError: (e) {
          print('DEBUG: STT Error: ${e.errorMsg} (Permanent: ${e.permanent})');
          error.value = e.errorMsg;
          isListening.value = false;
        },
        debugLogging: true, // Enable native logs
      );
      print('DEBUG: STT Initialization Result: ${isAvailable.value}');
    } catch (e) {
      isAvailable.value = false;
      error.value = e.toString();
      print('DEBUG: STT Initialization Exception: $e');
    }
  }

  void startListening({required Function(String) onResult}) {
    if (!isAvailable.value) {
      print('DEBUG: STT startListening called but not available. Current Error: ${error.value}');
      return;
    }

    print('DEBUG: STT starting to listen...');
    _stt.listen(
      onResult: (result) {
        print('DEBUG: STT Words recognized: ${result.recognizedWords} (Final: ${result.finalResult})');
        lastWords.value = result.recognizedWords;
        onResult(result.recognizedWords);
      },
      listenFor: const Duration(hours: 1),
      pauseFor: const Duration(seconds: 10),
      cancelOnError: false,
      partialResults: true,
      listenMode: ListenMode.confirmation, // Changed to confirmation for more "active" feedback
    );
  }

  void stopListening() {
    print('DEBUG: STT stopListening called');
    _stt.stop();
    isListening.value = false;
  }
}
