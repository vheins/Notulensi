import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notulensi/core/theme/notulensi_theme.dart';
import 'package:notulensi/shared/models/database/meeting_note.dart';
import 'package:notulensi/features/notes/logic/selection_controller.dart';

class NoteCard extends GetView<SelectionController> {
  final MeetingNote note;
  final VoidCallback onTap;

  const NoteCard({
    super.key,
    required this.note,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<NotulensiColors>()!;

    return Obx(() {
      final isSelected = controller.isSelected(note.id);
      final isMultiSelect = controller.isMultiSelectMode.value;

      return GestureDetector(
        onTap: isMultiSelect ? () => controller.toggleSelection(note.id) : onTap,
        onLongPress: () => controller.toggleSelection(note.id),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected ? colors.primary.withAlpha(40) : colors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? colors.primary : colors.primary.withAlpha(20),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              if (isMultiSelect) ...[
                Icon(
                  isSelected ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                  color: isSelected ? colors.primary : colors.textLow,
                ),
                const SizedBox(width: 16),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: colors.textHigh,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    if (note.transcript.isNotEmpty)
                      Text(
                        note.transcript,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: colors.textLow.withAlpha(200), fontSize: 13),
                      ),
                    const SizedBox(height: 8),
                    Text(
                      DateFormat('MMM dd, hh:mm a').format(note.createdAt),
                      style: TextStyle(color: colors.textLow, fontSize: 11),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: colors.textLow),
            ],
          ),
        ),
      );
    });
  }
}
