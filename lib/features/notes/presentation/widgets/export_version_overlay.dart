import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/notulensi_theme.dart';
import '../../services/versioning_service.dart';

class ExportVersionOverlay extends StatelessWidget {
  final int noteId;
  final Function(String) onRestore;

  const ExportVersionOverlay({
    super.key,
    required this.noteId,
    required this.onRestore,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<NotulensiColors>()!;
    final versioningService = Get.find<VersioningService>();

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface.withAlpha(200),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag Handle
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            const SizedBox(height: 24),
            Text(
              'EXPORT & HISTORY',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: colors.textHigh,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Actions
            _buildActionTile(
              context,
              label: 'SHARE AS PDF',
              icon: Icons.picture_as_pdf_outlined,
              onTap: () {},
            ),
            _buildActionTile(
              context,
              label: 'OFFLINE QR SYNC',
              icon: Icons.qr_code_scanner_rounded,
              onTap: () {},
            ),
            
            const Divider(height: 48, color: Colors.white10),
            
            // Version History Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'VERSION HISTORY',
                  style: TextStyle(color: colors.textLow, fontSize: 10, letterSpacing: 1, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            FutureBuilder(
              future: versioningService.getVersions(noteId),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Text('No snapshots available.', style: TextStyle(color: Colors.white24, fontSize: 12)),
                  );
                }

                final versions = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: versions.length,
                  itemBuilder: (context, index) {
                    final v = versions[index];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                      leading: Icon(Icons.history_rounded, color: colors.primary),
                      title: Text(
                        'Saved on ${DateFormat('MMM dd, HH:mm').format(v.createdAt)}',
                        style: const TextStyle(color: Colors.white, fontSize: 13),
                      ),
                      trailing: TextButton(
                        onPressed: () => _confirmRestore(context, v.transcript),
                        child: Text('RESTORE', style: TextStyle(color: colors.primary, fontSize: 11, fontWeight: FontWeight.bold)),
                      ),
                    );
                  },
                );
              },
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildActionTile(BuildContext context, {required String label, required IconData icon, required VoidCallback onTap}) {
    final colors = Theme.of(context).extension<NotulensiColors>()!;
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: colors.primary.withAlpha(30), shape: BoxShape.circle),
        child: Icon(icon, color: colors.primary, size: 20),
      ),
      title: Text(label, style: const TextStyle(color: Colors.white, fontSize: 14, letterSpacing: 0.5)),
      trailing: const Icon(Icons.chevron_right_rounded, color: Colors.white10),
    );
  }

  void _confirmRestore(BuildContext context, String transcript) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text('RESTORE VERSION?', style: TextStyle(color: Colors.white, fontSize: 16)),
        content: const Text('Current transcript will be replaced with this snapshot.', style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('CANCEL')),
          TextButton(
            onPressed: () {
              onRestore(transcript);
              Get.back(); // Close Dialog
              Get.back(); // Close Overlay
            },
            child: const Text('RESTORE', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }
}
