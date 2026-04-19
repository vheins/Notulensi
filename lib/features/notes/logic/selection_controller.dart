import 'package:get/get.dart';
import 'package:isar/isar.dart';

class SelectionController extends GetxController {
  final selectedIds = <Id>{}.obs;
  final isMultiSelectMode = false.obs;

  void toggleSelection(Id id) {
    if (selectedIds.contains(id)) {
      selectedIds.remove(id);
    } else {
      selectedIds.add(id);
    }

    if (selectedIds.isEmpty) {
      isMultiSelectMode.value = false;
    } else {
      isMultiSelectMode.value = true;
    }
  }

  void clearSelection() {
    selectedIds.clear();
    isMultiSelectMode.value = false;
  }

  bool isSelected(Id id) => selectedIds.contains(id);
}
