// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fl_chart/fl_chart.dart';

class LineChartSample4 extends StatelessWidget {
  LineChartSample4({
    super.key,
    required this.mainLineColor,
    required this.belowLineColor,
    required this.aboveLineColor,
  });

  final Color mainLineColor;
  final Color belowLineColor;
  final Color aboveLineColor;

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    String text;

    switch (value.toInt()) {
      case 0:
        text = DateTime.now().add(Duration(days: -11)).day.toString();
        break;
      case 1:
        text = DateTime.now().add(Duration(days: -10)).day.toString();
        break;
      case 2:
        text = DateTime.now().add(Duration(days: -9)).day.toString();
        break;
      case 3:
        text = DateTime.now().add(Duration(days: -8)).day.toString();
        break;
      case 4:
        text = DateTime.now().add(Duration(days: -7)).day.toString();
        break;
      case 5:
        text = DateTime.now().add(Duration(days: -6)).day.toString();
        break;
      case 6:
        text = DateTime.now().add(Duration(days: -5)).day.toString();
        break;
      case 7:
        text = DateTime.now().add(Duration(days: -4)).day.toString();
        break;
      case 8:
        text = DateTime.now().add(Duration(days: -3)).day.toString();
        break;
      case 9:
        text = DateTime.now().add(Duration(days: -2)).day.toString();
        break;
      case 10:
        text = DateTime.now().add(Duration(days: -1)).day.toString();
        break;
      case 11:
        text = DateTime.now().day.toString();
        break;
      default:
        return Container();
    }

    return SideTitleWidget(
      meta: meta,
      space: 4,
      child: Text(
        "$text日",
        style: TextStyle(
          fontSize: 10,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.white, fontSize: 12);
    return SideTitleWidget(
      meta: meta,
      child: Text(value.toString(), style: style),
    );
  }

  @override
  Widget build(BuildContext context) {
    const cutOffYValue = 5.0;

    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 28, top: 22, bottom: 12),
      child: LineChart(
        LineChartData(
          lineTouchData: const LineTouchData(enabled: false),
          lineBarsData: [
            LineChartBarData(
              spots: const [
                FlSpot(0, 10),
                FlSpot(1, 3.5),
                FlSpot(2, 4.5),
                FlSpot(3, 1),
                FlSpot(4, 4),
                FlSpot(5, 6),
                FlSpot(6, 6.5),
                FlSpot(7, 6),
                FlSpot(8, 4),
                FlSpot(9, 6),
                FlSpot(10, 6),
                FlSpot(11, 7),
              ],
              isCurved: true,
              barWidth: 8,
              color: mainLineColor,
              belowBarData: BarAreaData(
                show: true,
                color: belowLineColor,
                cutOffY: cutOffYValue,
                applyCutOffY: true,
              ),
              aboveBarData: BarAreaData(
                show: true,
                color: aboveLineColor,
                cutOffY: cutOffYValue,
                applyCutOffY: true,
              ),
              dotData: const FlDotData(show: false),
            ),
          ],
          minY: 0,
          titlesData: FlTitlesData(
            show: true,
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              axisNameWidget: Text(
                '',
                style: TextStyle(
                  fontSize: 10,
                  color: mainLineColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 18,
                interval: 1,
                getTitlesWidget: bottomTitleWidgets,
              ),
            ),
            leftTitles: AxisTitles(
              axisNameSize: 20,
              axisNameWidget: const Text(
                '投稿数',
                style: TextStyle(color: Colors.black),
              ),
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                reservedSize: 40,
                getTitlesWidget: leftTitleWidgets,
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,

            border: Border.all(color: Colors.black),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 1,
            checkToShowHorizontalLine: (double value) {
              return value == 1 || value == 6 || value == 4 || value == 5;
            },
          ),
        ),
      ),
    );
  }
}
