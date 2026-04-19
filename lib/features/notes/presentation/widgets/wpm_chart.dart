import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/theme/notulensi_theme.dart';

class WpmChart extends StatelessWidget {
  final List<double> series;

  const WpmChart({super.key, required this.series});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<NotulensiColors>()!;

    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: series.length.toDouble() - 1,
          minY: 0,
          maxY: (series.isNotEmpty ? series.reduce(max) : 100) + 20,
          lineBarsData: [
            LineChartBarData(
              spots: series.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value)).toList(),
              isCurved: true,
              color: colors.primary,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: colors.primary.withAlpha(20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
