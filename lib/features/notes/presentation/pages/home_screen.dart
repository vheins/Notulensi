import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notulensi/core/theme/notulensi_theme.dart';
import 'package:notulensi/features/notes/logic/note_list_controller.dart';
import 'package:notulensi/features/notes/logic/selection_controller.dart';
import 'package:notulensi/features/notes/presentation/widgets/note_card.dart';

class HomeScreen extends GetView<NoteListController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<NotulensiColors>()!;
    final selectionController = Get.find<SelectionController>();

    return Scaffold(
      backgroundColor: colors.background,
      body: Obx(() {
        final isSelectionMode = selectionController.isMultiSelectMode.value;

        return RefreshIndicator(
          onRefresh: controller.refreshNotes,
          child: CustomScrollView(
            slivers: [
              // Sticky Search Bar or Selection Bar
              SliverAppBar(
                floating: true,
                pinned: true,
                expandedHeight: isSelectionMode ? 80 : 180,
                backgroundColor: colors.background,
                leading: isSelectionMode
                  ? IconButton(icon: const Icon(Icons.close), onPressed: selectionController.clearSelection)
                  : null,
                title: isSelectionMode
                  ? Text('${selectionController.selectedIds.length} SELECTED')
                  : Text(
                      'ARCHIVE',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        letterSpacing: 2,
                        color: colors.textHigh,
                        fontSize: 20,
                      ),
                    ),
                centerTitle: false,
                actions: isSelectionMode ? [
                  IconButton(
                    icon: const Icon(Icons.delete_outline_rounded),
                    onPressed: () {
                      // TODO: Bulk delete logic
                      selectionController.clearSelection();
                    },
                  ),
                ] : null,
                flexibleSpace: isSelectionMode ? null : FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  title: const SizedBox.shrink(),
                  background: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: TextField(
                          onChanged: controller.updateSearch,
                          style: TextStyle(color: colors.textHigh),
                          decoration: InputDecoration(
                            hintText: 'SEARCH NOTES...',
                            hintStyle: TextStyle(color: colors.textLow, fontSize: 12, letterSpacing: 1),
                            prefixIcon: Icon(Icons.search, color: colors.textLow),
                            filled: true,
                            fillColor: colors.surface,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 48),
                    ],
                  ),
                ),
              ),

              // Note List
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: Obx(() {
                  if (controller.isLoading.value) {
                    return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
                  }

                  if (controller.notes.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.note_alt_outlined,
                                size: 64,
                                color: colors.textLow,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No notes yet',
                                style: TextStyle(
                                  color: colors.textHigh,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Tap the microphone to record your first note',
                                style: TextStyle(
                                  color: colors.textLow,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
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
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/recording'),
        backgroundColor: colors.primary,
        child: const Icon(Icons.mic_none_rounded, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
