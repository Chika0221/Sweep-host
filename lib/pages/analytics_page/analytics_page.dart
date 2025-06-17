// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:sweep_host/pages/analytics_page/analytics_info_card.dart';
import 'package:sweep_host/pages/analytics_page/bento_flame.dart';
import 'package:sweep_host/pages/analytics_page/post_peek_chart.dart';
import 'package:sweep_host/pages/dashboard_page/post_data_chart.dart';
import 'package:sweep_host/states/user_stream_provider.dart';

part 'user_count_info_card.dart';

class AnalyticsPage extends HookConsumerWidget {
  const AnalyticsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget errorWidget(error, stackTrace) {
      return Text("エラー $error");
    }

    Widget loadingWidget() {
      return CircularProgressIndicator();
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
      child: LayoutGrid(
        columnGap: 12,
        rowGap: 12,
        areas: '''
          userCount j k k l
          post post post peek peek
          f f f f f 
        ''',

        columnSizes: [1.0.fr, 1.0.fr, 0.6.fr, 0.4.fr, 1.0.fr],
        rowSizes: [0.6.fr, 2.4.fr, 1.0.fr],
        children: [
          gridArea("userCount").containing(
            BentoFlame(
              child: UserCountInfoCard(
                errorWidget: errorWidget,
                loadingWidget: loadingWidget,
              ),
            ),
          ),
          // gridArea("j").containing(BentoFlame(child: AnalyticsInfoCard())),
          // gridArea("k").containing(BentoFlame(child: AnalyticsInfoCard())),
          // gridArea("l").containing(BentoFlame(child: AnalyticsInfoCard())),
          gridArea("post").containing(BentoFlame(child: PostDataChart())),
          gridArea("peek").containing(BentoFlame(child: PostPeekChart())),
          gridArea(
            "f",
          ).containing(BentoFlame(child: Container(color: Colors.orange))),
        ],
      ),
    );
  }
}
