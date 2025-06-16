// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:sweep_host/pages/analytics_page/bento_flame.dart';
import 'package:sweep_host/pages/dashboard_page/post_data_chart.dart';

class AnalyticsPage extends HookConsumerWidget {
  const AnalyticsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutGrid(
      columnGap: 12,
      rowGap: 12,
      areas: '''
          i j k k l
          post post post peek peek
          f f f f f 
        ''',

      columnSizes: [1.0.fr, 1.0.fr, 0.6.fr, 0.4.fr, 1.0.fr],
      rowSizes: [1.0.fr, 2.4.fr, 0.6.fr],
      children: [
        gridArea(
          "i",
        ).containing(BentoFlame(child: Container(color: Colors.amber))),
        gridArea(
          "j",
        ).containing(BentoFlame(child: Container(color: Colors.blue))),
        gridArea(
          "k",
        ).containing(BentoFlame(child: Container(color: Colors.green))),
        gridArea(
          "l",
        ).containing(BentoFlame(child: Container(color: Colors.red))),
        gridArea("post").containing(BentoFlame(child: PostDataChart())),
        gridArea(
          "f",
        ).containing(BentoFlame(child: Container(color: Colors.orange))),
        gridArea(
          "peek",
        ).containing(BentoFlame(child: Container(color: Colors.black))),
      ],
    );
  }
}
