import 'package:get/get.dart';
import '../logic/note_detail_controller.dart';
import '../../../core/database/isar_service.dart';

class NoteDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NoteDetailController>(
      () => NoteDetailController(isarService: Get.find<IsarService>()),
    );
  }
}
