// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fl_chart/fl_chart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:sweep_host/states/post_stream_provider.dart';

const int displayDayNumber = 14;

class PostDataChart extends HookConsumerWidget {
  const PostDataChart({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postStream = ref.watch(postStreamProvider);

    return postStream.when(
      data: (data) {
        double toDay = (DateTime.now().day - displayDayNumber).toDouble();

        List<FlSpot> spots = [];
        for (var i = 0; i < displayDayNumber; i++) {
          final day = toDay + i;
          double value = 0;

          for (var post in data) {
            if (post.time.day == day.toInt()) {
              value += 1;
            }
          }

          spots.add(FlSpot(day, value));
        }

        return Padding(
          padding: EdgeInsets.all(16),
          child: LineChart(
            LineChartData(
              lineTouchData: LineTouchData(
                enabled: true,
                touchTooltipData: LineTouchTooltipData(
                  getTooltipItems: (touchedSpots) {
                    return touchedSpots.map((spot) {
                      return LineTooltipItem(
                        '${spot.x.toInt()}日: ${spot.y.toInt()}投稿',
                        TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }).toList();
                  },
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: false,
                  barWidth: 8,
                  dotData: FlDotData(show: true),
                  color: Theme.of(context).colorScheme.primary,
                  belowBarData: BarAreaData(
                    show: false,
                    color: Theme.of(
                      context,
                    ).colorScheme.secondaryContainer.withAlpha(100),
                  ),
                  aboveBarData: BarAreaData(
                    show: false,
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                ),
              ],
              minY: 0,
              maxY: spots.map((e) => e.y).reduce(max) + 1,
              titlesData: FlTitlesData(
                show: true,
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      return SideTitleWidget(
                        meta: meta,
                        child: Text("$value日"),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  axisNameSize: 20,
                  axisNameWidget: const Text('投稿数'),
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      return SideTitleWidget(
                        child: Text(value.toString()),
                        meta: meta,
                      );
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: false,
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                  width: 1,
                ),
              ),
              gridData: FlGridData(
                show: true,
                drawHorizontalLine: true,
                drawVerticalLine: false,
                horizontalInterval: 1,
              ),
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return Center(
          child: Text('Error: $error', style: TextStyle(color: Colors.red)),
        );
      },
      loading: () {
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
