import 'package:get/get.dart';
import '../logic/note_detail_controller.dart';
import '../../../core/database/isar_service.dart';
import '../../recording/logic/audio_playback_controller.dart';
import '../../recording/services/audio_player_service.dart';

class NoteDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NoteDetailController>(
      () => NoteDetailController(isarService: Get.find<IsarService>()),
    );
    
    Get.lazyPut<AudioPlaybackController>(
      () => AudioPlaybackController(service: Get.find<AudioPlayerService>()),
    );
  }
}
