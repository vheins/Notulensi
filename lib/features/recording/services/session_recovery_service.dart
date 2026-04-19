import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class RecordingSessionMetadata {
  final String title;
  final String audioPath;
  final DateTime startTime;
  final String transcript;

  RecordingSessionMetadata({
    required this.title,
    required this.audioPath,
    required this.startTime,
    this.transcript = '',
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'audioPath': audioPath,
    'startTime': startTime.toIso8601String(),
    'transcript': transcript,
  };

  factory RecordingSessionMetadata.fromJson(Map<String, dynamic> json) => RecordingSessionMetadata(
    title: json['title'],
    audioPath: json['audioPath'],
    startTime: DateTime.parse(json['startTime']),
    transcript: json['transcript'] ?? '',
  );
}

class SessionRecoveryService {
  static const _tempMetadataFile = 'pending_session.json';

  Future<void> persistSession(RecordingSessionMetadata metadata) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$_tempMetadataFile');
    await file.writeAsString(jsonEncode(metadata.toJson()));
  }

  Future<RecordingSessionMetadata?> getPendingSession() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$_tempMetadataFile');
    
    if (await file.exists()) {
      try {
        final content = await file.readAsString();
        return RecordingSessionMetadata.fromJson(jsonDecode(content));
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  Future<void> clearPendingSession() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$_tempMetadataFile');
    if (await file.exists()) {
      await file.delete();
    }
  }

  /// Checks if the audio file referenced in metadata actually exists.
  Future<bool> isAudioDataSafe(RecordingSessionMetadata metadata) async {
    return await File(metadata.audioPath).exists();
  }
}
