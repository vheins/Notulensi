import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:notulensi/core/theme/notulensi_theme.dart';
import 'package:notulensi/features/storage/logic/storage_dashboard_controller.dart';

class StorageDashboardScreen extends GetView<StorageDashboardController> {
  const StorageDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<NotulensiColors>()!;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: const Text('STORAGE OCCUPANCY', style: TextStyle(letterSpacing: 2, fontSize: 16)),
        backgroundColor: colors.background,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final audio = controller.audioSize.value;
        final db = controller.dbSize.value;
        final total = audio + db;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Pie Chart
              SizedBox(
                height: 250,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 4,
                    centerSpaceRadius: 60,
                    sections: [
                      PieChartSectionData(
                        value: audio,
                        title: '',
                        color: colors.primary,
                        radius: 20,
                      ),
                      PieChartSectionData(
                        value: db,
                        title: '',
                        color: colors.success,
                        radius: 20,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Legend/Stats
              _StorageRow(
                label: 'AUDIO RECORDINGS',
                size: '${audio.toStringAsFixed(2)} MB',
                color: colors.primary,
              ),
              const SizedBox(height: 16),
              _StorageRow(
                label: 'DATABASE (ISAR)',
                size: '${db.toStringAsFixed(2)} MB',
                color: colors.success,
              ),
              const Divider(height: 48, color: Colors.white10),
              _StorageRow(
                label: 'TOTAL USED',
                size: '${total.toStringAsFixed(2)} MB',
                color: Colors.white,
                isBold: true,
              ),

              const SizedBox(height: 48),

              // Action
              OutlinedButton.icon(
                onPressed: () => controller.calculateUsage(),
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('RE-CALCULATE'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  side: BorderSide(color: colors.primary.withAlpha(100)),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _StorageRow extends StatelessWidget {
  final String label;
  final String size;
  final Color color;
  final bool isBold;

  const _StorageRow({
    required this.label,
    required this.size,
    required this.color,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<NotulensiColors>()!;
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 16),
        Text(
          label,
          style: TextStyle(
            color: isBold ? colors.textHigh : colors.textLow,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            letterSpacing: 1,
            fontSize: 12,
          ),
        ),
        const Spacer(),
        Text(
          size,
          style: TextStyle(
            color: colors.textHigh,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontFamily: 'Geist',
          ),
        ),
      ],
    );
  }
}
