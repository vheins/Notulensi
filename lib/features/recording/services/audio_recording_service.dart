import 'dart:io';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:get/get.dart';

class AudioRecordingService extends GetxService {
  final AudioRecorder _recorder = AudioRecorder();
  final isRecording = false.obs;

  Future<String?> start() async {
    try {
      if (await _recorder.hasPermission()) {
        final directory = await getApplicationDocumentsDirectory();
        final fileName = 'rec_${DateTime.now().millisecondsSinceEpoch}.m4a';
        
        // Ensure recordings directory exists
        final recDir = Directory(p.join(directory.path, 'recordings'));
        if (!await recDir.exists()) {
          await recDir.create(recursive: true);
        }
        
        final path = p.join(recDir.path, fileName);

        const config = RecordConfig(); // Default config (m4a/aac)

        await _recorder.start(config, path: path);
        isRecording.value = true;
        print('DEBUG: Recording started at $path');
        return path;
      }
    } catch (e) {
      print('DEBUG: Audio recording start failed: $e');
    }
    return null;
  }

  Future<String?> stop() async {
    try {
      final path = await _recorder.stop();
      isRecording.value = false;
      print('DEBUG: Recording stopped, file saved at $path');
      return path;
    } catch (e) {
      print('DEBUG: Audio recording stop failed: $e');
      return null;
    }
  }

  Future<void> dispose() async {
    await _recorder.dispose();
  }
}
