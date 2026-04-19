import 'dart:async';
import 'dart:math';
import 'package:get/get.dart';

class RecordingController extends GetxController {
  final amplitudes = <double>[].obs;
  final isRecording = false.obs;
  final duration = Duration.zero.obs;
  final transcript = ''.obs;

  Timer? _timer;
  Timer? _amplitudeTimer;

  void startRecording() {
    isRecording.value = true;
    amplitudes.clear();
    duration.value = Duration.zero;
    transcript.value = '';

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      duration.value += const Duration(seconds: 1);
    });

    // Simulate live amplitudes
    _amplitudeTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      final random = Random();
      amplitudes.add(random.nextDouble());
      if (amplitudes.length > 100) amplitudes.removeAt(0);
    });

    // Simulate live transcription
    Future.delayed(const Duration(seconds: 2), () {
      if (isRecording.value) transcript.value = 'Initializing high-fidelity local transcription...';
    });
  }

  void stopRecording() {
    isRecording.value = false;
    _timer?.cancel();
    _amplitudeTimer?.cancel();
  }

  void addMarker() {
    // TODO: Implement bookmarking
  }

  @override
  void onClose() {
    _timer?.cancel();
    _amplitudeTimer?.cancel();
    super.onClose();
  }
}
