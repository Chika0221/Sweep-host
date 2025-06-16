// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fl_chart/fl_chart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:sweep_host/states/post_stream_provider.dart';

class PostPeekChart extends HookConsumerWidget {
  const PostPeekChart({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "投稿のピーク",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          height: 64,
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 16),
              Icon(
                Icons.local_fire_department_rounded,
                color: Colors.deepOrangeAccent,
                size: 32,
              ),
              Spacer(),

              Text(
                '10:00',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              SizedBox(width: 16),
            ],
          ),
        ),
        SizedBox(height: 64),
        Expanded(child: PeekChart()),
      ],
    );
  }
}

class PeekChart extends HookConsumerWidget {
  const PeekChart({super.key});

  Widget getBottomTitle(double value, TitleMeta meta) {
    final dataMap = {
      1: "月曜日",
      2: "火曜日",
      3: "水曜日",
      4: "木曜日",
      5: "金曜日",
      6: "土曜日",
      7: "日曜日",
    };

    return Text(dataMap[value] ?? '');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postStream = ref.watch(postStreamProvider);

    return postStream.when(
      data: (data) {
        List<BarChartGroupData> barData = [];

        for (var i = 1; i <= 7; i++) {
          double value = 0;
          for (var post in data) {
            if (post.time.weekday == i) {
              value += 1;
            }
          }
          barData.add(
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: value,
                  width: 30,
                  color: Colors.deepOrangeAccent,
                  borderRadius: BorderRadius.circular(8),
                ),
              ],
              // showingTooltipIndicators: [0],
              groupVertically: true,
            ),
          );
        }

        return BarChart(
          BarChartData(
            barGroups: barData,
            barTouchData: BarTouchData(
              enabled: true,
              touchTooltipData: BarTouchTooltipData(
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  return BarTooltipItem(
                    "${rod.toY}",
                    Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.deepOrangeAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
                getTooltipColor: (group) {
                  return Colors.transparent;
                },
              ),
            ),
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 38,
                  getTitlesWidget: getBottomTitle,
                ),
              ),
            ),
            borderData: FlBorderData(
              show: false,
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
                width: 1.0,
              ),
            ),
          ),
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error:
          (error, stackTrace) => Center(
            child: Text(
              'Error loading data: $error',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
    );
  }
}
