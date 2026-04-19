import 'dart:async';
import 'dart:math';
import 'package:get/get.dart';
import '../../notes/services/note_management_service.dart';
import '../../intelligence/services/stt_service.dart';
import '../../../core/permissions/permission_service.dart';
import '../services/audio_recording_service.dart';

class RecordingController extends GetxController {
  // Use Get.find lazily
  NoteManagementService get _noteManagementService => Get.find<NoteManagementService>();
  SttService get _sttService => Get.find<SttService>();
  PermissionService get _permissionService => Get.find<PermissionService>();
  AudioRecordingService get _recordingService => Get.find<AudioRecordingService>();

  final amplitudes = <double>[].obs;
  final isRecording = false.obs;
  final duration = Duration.zero.obs;
  final transcript = ''.obs;
  String? currentAudioPath;

  Timer? _timer;
  Timer? _amplitudeTimer;

  @override
  void onInit() {
    super.onInit();
    // Initialize STT early
    _sttService.init();
  }

  Future<void> startRecording() async {
    print('DEBUG: RecordingController.startRecording() triggered');
    
    // Check and request permissions (Mic + Bluetooth for STT)
    final hasMic = await _permissionService.requestMicrophone();
    if (!hasMic) {
      Get.snackbar('Permission Denied', 'Microphone access is required.');
      return;
    }

    // Start Actual Audio Recording FIRST
    currentAudioPath = await _recordingService.start();
    if (currentAudioPath == null) {
      Get.snackbar('Error', 'Failed to start audio recording.');
      return;
    }

    isRecording.value = true;
    amplitudes.clear();
    duration.value = Duration.zero;
    transcript.value = '';

    // Start Real STT with explicit check
    if (_sttService.isAvailable.value) {
      _sttService.startListening(onResult: (text) {
        print('DEBUG: STT Callback update: "$text"');
        transcript.value = text;
      });
    } else {
      print('DEBUG: STT not available at start, re-initializing...');
      await _sttService.init();
      if (_sttService.isAvailable.value) {
        _sttService.startListening(onResult: (text) {
          transcript.value = text;
        });
      }
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      duration.value += const Duration(seconds: 1);
    });

    _amplitudeTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      final random = Random();
      amplitudes.add(random.nextDouble());
      if (amplitudes.length > 100) amplitudes.removeAt(0);
    });
  }

  void stopRecording() {
    print('DEBUG: RecordingController.stopRecording() called');
    isRecording.value = false;
    _timer?.cancel();
    _amplitudeTimer?.cancel();
    _sttService.stopListening();
    _recordingService.stop();
  }

  Future<void> stopAndSave() async {
    print('DEBUG: RecordingController.stopAndSave() starting');
    
    // Capture values
    final finalTranscript = transcript.value;
    final finalDuration = duration.value;
    
    // Ensure stop is awaited
    final stoppedPath = await _recordingService.stop();
    final audioFileToSave = stoppedPath ?? currentAudioPath;
    
    stopRecording();

    try {
      if (audioFileToSave != null || finalTranscript.isNotEmpty || finalDuration.inSeconds > 1) {
        final title = 'Recording ${DateTime.now().toString().substring(0, 16)}';
        
        // Final fallback text
        String cleanTranscript = finalTranscript.trim();
        if (cleanTranscript.isEmpty) {
          if (!_sttService.isAvailable.value) {
            cleanTranscript = 'STT Error: Engine not available on this device.';
          } else {
            cleanTranscript = 'No speech detected during recording.';
          }
        }

        await _noteManagementService.createNoteWithAudio(
          title: title, 
          transcript: cleanTranscript,
          duration: finalDuration.inSeconds,
          audioPath: audioFileToSave,
        );
        print('DEBUG: Saved Note. Transcript: "$cleanTranscript"');
      }
    } catch (e) {
      print('DEBUG: Error saving note: $e');
    }

    Get.back();
  }

  @override
  void onClose() {
    _timer?.cancel();
    _amplitudeTimer?.cancel();
    _sttService.stopListening();
    _recordingService.stop();
    super.onClose();
  }
}
