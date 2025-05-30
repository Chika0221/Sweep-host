// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:sweep_host/pages/dashboard_page/line_shart.dart';

class DashboardPage extends HookConsumerWidget {
  const DashboardPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Column(
        children: [
          Flexible(flex: 2, child: Container(color: Colors.amber)),
          Flexible(
            flex: 3,
            child: LineChartSample4(
              mainLineColor: Colors.blue,
              belowLineColor: Colors.blue.withAlpha(100),
              aboveLineColor: Colors.grey.withAlpha(100),
            ),
          ),
        ],
      ),
    );
  }
}
