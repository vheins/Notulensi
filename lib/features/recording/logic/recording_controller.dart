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
  
  // Guard to prevent multiple stop/save calls
  bool _isStopping = false;

  Timer? _timer;
  Timer? _amplitudeTimer;

  @override
  void onInit() {
    super.onInit();
    _sttService.init();
  }

  Future<void> startRecording() async {
    if (isRecording.value) return;

    print('DEBUG: RecordingController.startRecording() triggered');
    
    final hasMic = await _permissionService.requestMicrophone();
    if (!hasMic) {
      Get.snackbar('Permission Denied', 'Microphone access is required.');
      return;
    }

    currentAudioPath = await _recordingService.start();
    if (currentAudioPath == null) {
      print('DEBUG: Failed to start audio recorder');
      Get.snackbar('Error', 'Failed to start audio recording.');
      return;
    }

    isRecording.value = true;
    _isStopping = false;
    amplitudes.clear();
    duration.value = Duration.zero;
    transcript.value = '';

    if (_sttService.isAvailable.value) {
      _sttService.startListening(onResult: (text) {
        transcript.value = text;
      });
    } else {
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

  /// Internal method to stop all recording components ONCE
  Future<String?> _performStop() async {
    if (!isRecording.value) return null;
    
    print('DEBUG: Performing internal stop...');
    isRecording.value = false;
    
    _timer?.cancel();
    _amplitudeTimer?.cancel();
    _sttService.stopListening();
    
    // Return the path from the recorder
    return await _recordingService.stop();
  }

  void stopRecording() {
    _performStop();
  }

  Future<void> stopAndSave() async {
    if (_isStopping) return;
    _isStopping = true;

    print('DEBUG: RecordingController.stopAndSave() starting');
    
    final finalTranscript = transcript.value;
    final finalDuration = duration.value;
    
    final stoppedPath = await _performStop();
    final audioFileToSave = stoppedPath ?? currentAudioPath;

    try {
      if (audioFileToSave != null || finalTranscript.isNotEmpty || finalDuration.inSeconds > 1) {
        final title = 'Recording ${DateTime.now().toString().substring(0, 16)}';
        
        String cleanTranscript = finalTranscript.trim();
        if (cleanTranscript.isEmpty) {
          cleanTranscript = _sttService.isAvailable.value 
              ? 'No speech detected during recording.' 
              : 'STT Error: Engine not available.';
        }

        await _noteManagementService.createNoteWithAudio(
          title: title, 
          transcript: cleanTranscript,
          duration: finalDuration.inSeconds,
          audioPath: audioFileToSave,
        );
        print('DEBUG: Note saved successfully.');
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
