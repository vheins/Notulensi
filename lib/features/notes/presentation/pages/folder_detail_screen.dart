import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notulensi/core/theme/notulensi_theme.dart';
import 'package:notulensi/features/notes/logic/folder_detail_controller.dart';
import 'package:notulensi/features/notes/presentation/widgets/note_card.dart';

class FolderDetailScreen extends GetView<FolderDetailController> {
  const FolderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<NotulensiColors>()!;
    final folderId = Get.parameters['id'];

    if (folderId != null) {
      controller.fetchFolder(int.parse(folderId));
    }

    return Scaffold(
      backgroundColor: colors.background,
      body: Obx(() {
        final folder = controller.folder.value;
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (folder == null) {
          return const Center(child: Text('Folder not found'));
        }

        return CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 120,
              backgroundColor: colors.background,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                title: Text(
                  folder.name.toUpperCase(),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    letterSpacing: 2,
                    color: colors.textHigh,
                    fontSize: 20,
                  ),
                ),
                centerTitle: false,
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  onPressed: () {
                    _showEditDialog(context, folder.name);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline_rounded),
                  color: colors.error,
                  onPressed: () {
                    _showDeleteConfirm(context);
                  },
                ),
              ],
            ),

            // Note List
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: Obx(() {
                if (controller.notes.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 100),
                        child: Text('No notes in this folder.'),
                      ),
                    ),
                  );
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final note = controller.notes[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: NoteCard(
                          note: note,
                          onTap: () => Get.toNamed('/notes/${note.id}'),
                        ),
                      );
                    },
                    childCount: controller.notes.length,
                  ),
                );
              }),
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Open recording screen with this folder selected
        },
        backgroundColor: colors.primary,
        child: const Icon(Icons.mic_none_rounded, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _showEditDialog(BuildContext context, String currentName) {
    final textController = TextEditingController(text: currentName);
    Get.dialog(
      AlertDialog(
        title: const Text('RENAME FOLDER'),
        content: TextField(
          controller: textController,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Folder Name'),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('CANCEL')),
          TextButton(
            onPressed: () {
              controller.updateFolderName(textController.text);
              Get.back();
            },
            child: const Text('SAVE'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirm(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: const Text('DELETE FOLDER?'),
        content: const Text('Notes inside this folder will be moved to the default archive.'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('CANCEL')),
          TextButton(
            onPressed: () => controller.deleteFolder(),
            child: const Text('DELETE', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
