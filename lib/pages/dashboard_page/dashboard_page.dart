// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:sweep_host/pages/dashboard_page/info_plate.dart';
import 'package:sweep_host/pages/dashboard_page/line_shart.dart';
import 'package:sweep_host/pages/dashboard_page/submit_trashbox.dart';
import 'package:sweep_host/pages/dashboard_page/trashbox_state_list_view.dart';

class DashboardPage extends HookConsumerWidget {
  const DashboardPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Flexible(
                  child: InfoPlate()
                ),
                Flexible(
                  child: LineChartSample4(
                    mainLineColor: Colors.blue,
                    belowLineColor: Colors.blue.withAlpha(100),
                    aboveLineColor: Colors.grey.withAlpha(100),
                  ),
                ),
              ],
            ),
          ),
          VerticalDivider(indent: 16, endIndent: 16),
          SizedBox(
            width: 300,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: TrashboxStateListView()),
                  SubmitTrashboxButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
