import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/notulensi_theme.dart';
import '../../logic/note_list_controller.dart';
import '../widgets/note_card.dart';

class HomeScreen extends GetView<NoteListController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<NotulensiColors>()!;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Sticky Search Bar
          SliverAppBar(
            floating: true,
            pinned: true,
            expandedHeight: 120,
            backgroundColor: colors.background,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              title: Text(
                'ARCHIVE',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  letterSpacing: 2,
                  color: colors.textHigh,
                ),
              ),
              centerTitle: false,
            ),
          ),

          // Insights Ribbon
          SliverToBoxAdapter(
            child: Container(
              height: 100,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildInsightCard(context, 'NOTES', '45', colors.primary),
                  _buildInsightCard(context, 'PENDING', '12', colors.error),
                  _buildInsightCard(context, 'SAVED', '1.2 GB', colors.success),
                ],
              ),
            ),
          ),

          // Note List
          Obx(() {
            if (controller.isLoading.value && controller.notes.isEmpty) {
              return const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              );
            }

            if (controller.notes.isEmpty) {
              return SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.mic_none_rounded, size: 64, color: colors.textLow),
                      const SizedBox(height: 16),
                      Text(
                        'NO NOTES FOUND',
                        style: TextStyle(color: colors.textLow, letterSpacing: 2),
                      ),
                    ],
                  ),
                ),
              );
            }

            return SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final note = controller.notes[index];
                    return NoteCard(
                      note: note,
                      onTap: () {
                        // TODO: Navigate to Detail
                      },
                    );
                  },
                  childCount: controller.notes.length,
                ),
              ),
            );
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          // TODO: Start recording
        },
        backgroundColor: colors.primary,
        child: const Icon(Icons.mic, color: Colors.white),
      ),
    );
  }

  Widget _buildInsightCard(BuildContext context, String label, String value, Color accentColor) {
    final colors = Theme.of(context).extension<NotulensiColors>()!;
    
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 10, color: colors.textLow, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(fontSize: 18, color: accentColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
