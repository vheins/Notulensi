import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/notulensi_theme.dart';
import '../../../../core/ads/ad_service.dart';
import '../../../intelligence/services/stt_status_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<NotulensiColors>()!;
    final adService = Get.find<AdService>();
    final sttService = Get.find<SttStatusService>();

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: const Text('SETTINGS', style: TextStyle(letterSpacing: 2, fontSize: 16)),
        backgroundColor: colors.background,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // PRO Status Card
          Obx(() => _buildStatusCard(
            context,
            title: adService.isPro.value ? 'PRO ACCESS ACTIVE' : 'FREE TIER',
            subtitle: adService.isPro.value 
              ? 'Enjoy ad-free experience and premium features.' 
              : 'Unlock 24h Pro access by watching a short ad.',
            icon: Icons.auto_awesome_rounded,
            color: colors.primary,
            onTap: adService.isPro.value ? null : () => adService.showRewardAd(onRewardGranted: () {}),
          )),

          const SizedBox(height: 32),
          _buildSectionHeader('SECURITY'),
          _buildSettingTile(
            label: 'BIOMETRIC LOCK',
            icon: Icons.fingerprint_rounded,
            trailing: Switch(value: true, onChanged: (v) {}, activeTrackColor: colors.primary),
          ),
          _buildSettingTile(
            label: 'PRIVACY REDACTION',
            icon: Icons.visibility_off_outlined,
            trailing: Switch(value: true, onChanged: (v) {}, activeTrackColor: colors.primary),
          ),

          const SizedBox(height: 32),
          _buildSectionHeader('STORAGE'),
          _buildSettingTile(
            label: 'STORAGE DASHBOARD',
            icon: Icons.pie_chart_outline_rounded,
            onTap: () => Get.toNamed('/storage'),
          ),
          _buildSettingTile(
            label: 'AUTO-TRIM SILENCE',
            icon: Icons.content_cut_rounded,
            trailing: Switch(value: true, onChanged: (v) {}, activeTrackColor: colors.primary),
          ),

          const SizedBox(height: 32),
          _buildSectionHeader('INTELLIGENCE'),
          Obx(() => _buildSettingTile(
            label: 'OFFLINE STT STATUS',
            icon: Icons.offline_bolt_rounded,
            trailing: Text(
              sttService.isModelDownloaded.value ? 'READY' : 'REQUIRED',
              style: TextStyle(color: sttService.isModelDownloaded.value ? colors.success : colors.error, fontSize: 12, fontWeight: FontWeight.bold),
            ),
            onTap: () {},
          )),

          const SizedBox(height: 48),
          Center(
            child: Text(
              'NOTULENSI v1.0.0 (OFFLINE-FIRST)',
              style: TextStyle(color: colors.textLow, fontSize: 10, letterSpacing: 1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 4),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 2),
      ),
    );
  }

  Widget _buildSettingTile({required String label, required IconData icon, Widget? trailing, VoidCallback? onTap}) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.white70, size: 22),
      title: Text(label, style: const TextStyle(color: Colors.white, fontSize: 14, letterSpacing: 0.5)),
      trailing: trailing ?? const Icon(Icons.chevron_right_rounded, color: Colors.white24),
    );
  }

  Widget _buildStatusCard(BuildContext context, {required String title, required String subtitle, required IconData icon, required Color color, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: color.withAlpha(50)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold, letterSpacing: 1, fontSize: 14)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
