import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/notulensi_theme.dart';
import '../../logic/note_detail_controller.dart';
import '../widgets/audio_player_widget.dart';

class NoteDetailScreen extends GetView<NoteDetailController> {
  const NoteDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<NotulensiColors>()!;
    final noteId = Get.parameters['id'];

    if (noteId != null) {
      controller.fetchNote(int.parse(noteId));
    }

    return Scaffold(
      body: Obx(() {
        final note = controller.note.value;
        
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (note == null) {
          return const Center(child: Text('Note not found'));
        }

        return CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 150,
              backgroundColor: colors.background,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                title: Text(
                  note.title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: colors.textHigh,
                    fontSize: 20,
                  ),
                ),
                centerTitle: false,
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.history_rounded),
                  onPressed: () {
                    // TODO: Show version history
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.share_outlined),
                  onPressed: () {
                    // TODO: Export PDF
                  },
                ),
              ],
            ),

            // Top Info Ribbon
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 14, color: colors.textLow),
                        const SizedBox(width: 8),
                        Text(
                          DateFormat('EEEE, MMM dd, yyyy').format(note.createdAt),
                          style: TextStyle(color: colors.textLow, fontSize: 12),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: colors.success.withAlpha((0.15 * 255).round()),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'PROCESSED',
                            style: TextStyle(color: colors.success, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    // Highlights Area (Placeholder for Action Items/Deadlines)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: colors.primary.withAlpha((0.1 * 255).round())),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.auto_awesome, size: 16, color: colors.primary),
                              const SizedBox(width: 8),
                              Text(
                                'KEY HIGHLIGHTS',
                                style: TextStyle(
                                  color: colors.primary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'No action items extracted yet. Run intelligence pass to identify tasks.',
                            style: TextStyle(color: Colors.white70, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (note.audioPath != null)
                      AudioPlayerWidget(audioPath: note.audioPath!),
                  ],
                ),
              ),
            ),

            // Transcript Body
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(
                child: Text(
                  note.transcript.isNotEmpty ? note.transcript : 'Transcript is empty.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.6,
                    color: colors.textHigh.withAlpha((0.9 * 255).round()),
                  ),
                ),
              ),
            ),

            // Bottom spacer for bar
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        );
      }),
      bottomNavigationBar: _buildBottomActionBar(context),
    );
  }

  Widget _buildBottomActionBar(BuildContext context) {
    final colors = Theme.of(context).extension<NotulensiColors>()!;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: colors.background,
        border: Border(top: BorderSide(color: colors.surface, width: 1)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.play_arrow_rounded),
                label: const Text('LISTEN'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 12),
            IconButton.filledTonal(
              onPressed: () {},
              icon: const Icon(Icons.edit_note_rounded),
              style: IconButton.styleFrom(
                padding: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            IconButton.filledTonal(
              onPressed: () {},
              icon: const Icon(Icons.remove_red_eye_outlined),
              style: IconButton.styleFrom(
                padding: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
