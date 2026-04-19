import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:notulensi/features/recording/logic/recording_controller.dart';
import 'package:notulensi/features/notes/services/note_management_service.dart';
import 'package:notulensi/features/intelligence/services/stt_service.dart';
import 'package:notulensi/features/recording/services/audio_recording_service.dart';
import 'package:notulensi/core/permissions/permission_service.dart';

@GenerateNiceMocks([
  MockSpec<NoteManagementService>(),
  MockSpec<PermissionService>(),
])
import 'recording_controller_test.mocks.dart';

// Manual Mocks to avoid GetX lifecycle issues in tests
class ManualMockSttService extends SttService {
  bool startCalled = false;
  bool stopCalled = false;

  @override
  Future<void> init() async {}

  @override
  void startListening({required Function(String) onResult}) {
    startCalled = true;
  }

  @override
  void stopListening() {
    stopCalled = true;
  }
}

class ManualMockRecordingService extends AudioRecordingService {
  bool startCalled = false;
  bool stopCalled = false;

  @override
  Future<String?> start() async {
    startCalled = true;
    return 'test.m4a';
  }

  @override
  Future<String?> stop() async {
    stopCalled = true;
    return 'test.m4a';
  }
}

void main() {
  late RecordingController controller;
  late MockNoteManagementService mockNoteService;
  late ManualMockSttService mockSttService;
  late ManualMockRecordingService mockRecordingService;
  late MockPermissionService mockPermissionService;

  setUp(() {
    Get.testMode = true;
    mockNoteService = MockNoteManagementService();
    mockSttService = ManualMockSttService();
    mockRecordingService = ManualMockRecordingService();
    mockPermissionService = MockPermissionService();

    Get.put<NoteManagementService>(mockNoteService);
    Get.put<SttService>(mockSttService);
    Get.put<AudioRecordingService>(mockRecordingService);
    Get.put<PermissionService>(mockPermissionService);

    controller = RecordingController();
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('RecordingController startRecording should update state and start timers', (tester) async {
    when(mockPermissionService.requestMicrophone()).thenAnswer((_) async => true);
    
    await controller.startRecording();
    
    expect(controller.isRecording.value, true);
    expect(mockRecordingService.startCalled, true);
    
    // Wait for the delayed STT start
    await tester.pump(const Duration(milliseconds: 600));
    expect(mockSttService.startCalled, true);

    controller.stopRecording();
    await tester.pumpAndSettle();
  });

  testWidgets('RecordingController stopRecording should stop timers and update state', (tester) async {
    when(mockPermissionService.requestMicrophone()).thenAnswer((_) async => true);
    
    await controller.startRecording();
    // Wait for the delayed timer to fire BEFORE stopping, so we can clean it up
    await tester.pump(const Duration(milliseconds: 600));
    
    controller.stopRecording();
    
    expect(controller.isRecording.value, false);
    expect(mockSttService.stopCalled, true);
    expect(mockRecordingService.stopCalled, true);
    
    await tester.pumpAndSettle();
  });

  testWidgets('stopAndSave should call NoteManagementService when data exists', (tester) async {
    controller.transcript.value = 'Test transcript';
    controller.duration.value = const Duration(seconds: 10);
    controller.currentAudioPath = 'test_path.m4a';

    await controller.stopAndSave();

    verify(mockNoteService.createNoteWithAudio(
      title: anyNamed('title'),
      transcript: 'Test transcript',
      duration: 10,
      audioPath: anyNamed('audioPath'),
    )).called(1);
    
    await tester.pumpAndSettle();
  });
}
