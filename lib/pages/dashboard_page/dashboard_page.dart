// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:sweep_host/pages/dashboard_page/activity_list_view.dart';
import 'package:sweep_host/pages/dashboard_page/host_plate.dart';
import 'package:sweep_host/pages/dashboard_page/info_plate.dart';
import 'package:sweep_host/pages/dashboard_page/post_data_chart.dart';

class DashboardPage extends HookConsumerWidget {
  const DashboardPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Flexible(flex: 1, child: InfoPlate()),
              Flexible(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                    color: Theme.of(context).colorScheme.surfaceContainerLow,
                  ),
                  child: PostDataChart(),
                ),
              ),
            ],
          ),
        ),
        VerticalDivider(indent: 16, endIndent: 16),
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [HostPlate(), ActivityListView()],
            ),
          ),
        ),
      ],
    );
  }
}
