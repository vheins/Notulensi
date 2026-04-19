import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../../../core/database/isar_service.dart';
import '../../../shared/models/database/note_multimedia.dart';

class MultimediaService {
  final IsarService _isarService;
  final ImagePicker _picker = ImagePicker();

  MultimediaService({required IsarService isarService}) : _isarService = isarService;

  /// Captures a photo and anchors it to the given note and timestamp.
  Future<NoteMultimedia?> capturePhoto(int noteId, int timestampMs) async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo == null) return null;

    final directory = await getApplicationDocumentsDirectory();
    final fileName = 'note_${noteId}_$timestampMs${p.extension(photo.path)}';
    final savedPath = p.join(directory.path, 'media', fileName);

    // Ensure media directory exists
    final mediaDir = Directory(p.join(directory.path, 'media'));
    if (!await mediaDir.exists()) {
      await mediaDir.create(recursive: true);
    }

    // Move file to permanent storage
    await File(photo.path).copy(savedPath);

    final multimedia = NoteMultimedia()
      ..noteId = noteId
      ..timestampMs = timestampMs
      ..filePath = savedPath
      ..type = 'PHOTO'
      ..createdAt = DateTime.now();

    await _isarService.instance.writeTxn(() async {
      await _isarService.instance.noteMultimedias.put(multimedia);
    });

    return multimedia;
  }

  Future<List<NoteMultimedia>> getMultimediaForNote(int noteId) async {
    return await _isarService.instance.noteMultimedias
        .filter()
        .noteIdEqualTo(noteId)
        .sortByTimestampMs()
        .findAll();
  }
}
