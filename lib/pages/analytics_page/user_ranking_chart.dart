// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fl_chart/fl_chart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:sweep_host/classes/profile.dart';
import 'package:sweep_host/states/user_stream_provider.dart';

class UserRankingChart extends HookConsumerWidget {
  const UserRankingChart({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStream = ref.watch(userStreamProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "ポイントランキング",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 16.0),
        Expanded(
          child: userStream.when(
            data: (data) {
              List<BarChartGroupData> barData = [];

              List<Profile> sortedData = List.from(
                data,
              )..sort((a, b) => b.cumulativePoint.compareTo(a.cumulativePoint));

              for (var i = 1; i <= data.length; i++) {
                barData.add(
                  BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        toY: sortedData[i - 1].cumulativePoint.toDouble(),
                        width: 30,
                        color: Colors.lightGreen,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ],
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
                            color: Colors.lightGreen,
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
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text("$value");
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
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
          ),
        ),
      ],
    );
  }
}
