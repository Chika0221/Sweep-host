

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:sweep_host/states/post_stream_provider.dart';

// const int displayDayNumber.value = 14 ;

class PostDataChart extends HookConsumerWidget {
  const PostDataChart({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postStream = ref.watch(postStreamProvider);

    final displayDayNumber = useState(14);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        color: Theme.of(context).colorScheme.surfaceContainerLow,
      ),
      child: postStream.when(
        data: (data) {
          DateTime comparisonDay = DateTime.now().add(
            Duration(days: -displayDayNumber.value),
          );

          List<FlSpot> spots = [];
          for (var i = 0; i < displayDayNumber.value; i++) {
            final date = comparisonDay.add(Duration(days: i));
            double value = 0;

            for (var post in data) {
              if (post.time.day == date.day && post.time.month == date.month) {
                value += 1;
              }
            }

            spots.add(FlSpot(date.day.toDouble(), value));
          }

          print(spots);

          return Padding(
            padding: EdgeInsets.all(32),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "投稿数",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 4,
                      children: [
                        FilterChip(
                          label: Text("7日間"),
                          selected: displayDayNumber.value == 7,
                          onSelected: (selected) {
                            if (selected) {
                              displayDayNumber.value = 7;
                            }
                          },
                        ),
                        FilterChip(
                          label: Text("14日間"),
                          selected: displayDayNumber.value == 14,
                          onSelected: (selected) {
                            if (selected) {
                              displayDayNumber.value = 14;
                            }
                          },
                        ),
                        FilterChip(
                          label: Text("21日間"),
                          selected: displayDayNumber.value == 21,
                          onSelected: (selected) {
                            if (selected) {
                              displayDayNumber.value = 21;
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 32),
                Expanded(
                  child: LineChart(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
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
                          barWidth: 4,
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
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                          ),
                        ),
                      ],
                      minY: 0,
                      // maxY: spots.map((e) => e.y).reduce(max) + 1,
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
                ),
              ],
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
      ),
    );
  }
}
