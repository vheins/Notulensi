import 'dart:async';
import 'dart:math';
import 'package:get/get.dart';
import '../../notes/services/note_management_service.dart';
import '../../intelligence/services/stt_service.dart';
import '../../../core/permissions/permission_service.dart';
import '../../../core/navigation/app_routes.dart';
import '../services/audio_recording_service.dart';
import '../presentation/widgets/waveform_visualizer.dart';

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
  final markers = <WaveformMarker>[].obs;
  String? currentAudioPath;

  Timer? _timer;
  Timer? _amplitudeTimer;

  @override
  void onInit() {
    super.onInit();
    // Initialize STT early to reduce delay
    _sttService.init();
  }

  Future<void> startRecording() async {
    print('DEBUG: RecordingController.startRecording() triggered');
    
    // Check and request microphone permission
    final hasPermission = await _permissionService.requestMicrophone();
    if (!hasPermission) {
      print('DEBUG: Microphone permission denied');
      Get.snackbar('Permission Denied', 'Microphone access is required for recording.');
      return;
    }

    // Start Actual Audio Recording FIRST
    currentAudioPath = await _recordingService.start();
    if (currentAudioPath == null) {
      print('DEBUG: Failed to start audio recorder');
      Get.snackbar('Error', 'Failed to start audio recording.');
      return;
    }

    isRecording.value = true;
    amplitudes.clear();
    duration.value = Duration.zero;
    transcript.value = '';

    // Start Real STT
    // Give STT a small delay to ensure audio source is not contested
    Future.delayed(const Duration(milliseconds: 500), () {
      if (isRecording.value) {
        _sttService.startListening(onResult: (text) {
          print('DEBUG: STT Callback with text: "$text"');
          transcript.value = text;
        });
      }
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      duration.value += const Duration(seconds: 1);
    });

    // Simulate live amplitudes for visualizer
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

  void addMarker({String? label}) {
    if (!isRecording.value) return;
    markers.add(WaveformMarker(timestamp: duration.value, label: label));
  }

  Future<void> stopAndSave() async {
    print('DEBUG: RecordingController.stopAndSave() starting');

    final finalTranscript = transcript.value;
    final finalDuration = duration.value;

    final stoppedPath = await _recordingService.stop();
    final audioFileToSave = stoppedPath ?? currentAudioPath;

    stopRecording();

    try {
      if (audioFileToSave != null || finalTranscript.isNotEmpty || finalDuration.inSeconds > 1) {
        final title = 'Recording ${DateTime.now().toString().substring(0, 16)}';

        final cleanTranscript = finalTranscript.trim().isEmpty
            ? 'No transcript generated (Check microphone/internet).'
            : finalTranscript;

        final noteId = await _noteManagementService.createNoteWithAudio(
          title: title,
          transcript: cleanTranscript,
          duration: finalDuration.inSeconds,
          audioPath: audioFileToSave,
        );
        print('DEBUG: Note saved successfully. Audio: $audioFileToSave, Transcript Length: ${cleanTranscript.length}');

        Get.offNamed(AppRoutes.noteDetail, arguments: {'noteId': noteId});
      } else {
        print('DEBUG: Nothing to save (Empty audio and transcript)');
        Get.back();
      }
    } catch (e) {
      print('DEBUG: Error during note creation: $e');
      Get.back();
    }
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
