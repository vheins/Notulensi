import 'package:flutter/material.dart';
import '../../../../core/theme/notulensi_theme.dart';
import '../../../../shared/models/database/meeting_note.dart';
import 'package:intl/intl.dart';

class NoteCard extends StatelessWidget {
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
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      note.title,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: 18,
                        color: colors.textHigh,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: colors.primary.withAlpha(50),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'AUDIO',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: colors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                note.transcript.isNotEmpty 
                  ? note.transcript 
                  : 'No transcript available',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colors.textLow,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.access_time, size: 14, color: colors.textLow),
                  const SizedBox(width: 4),
                  Text(
                    DateFormat('MMM dd, yyyy').format(note.createdAt),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: colors.textLow,
                    ),
                  ),
                  const Spacer(),
                  if (note.tags.isNotEmpty)
                    ...note.tags.take(2).map((tag) => Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        '#$tag',
                        style: TextStyle(
                          fontSize: 12,
                          color: colors.primary,
                        ),
                      ),
                    )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
