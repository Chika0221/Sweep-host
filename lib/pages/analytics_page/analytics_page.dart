// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:sweep_host/pages/analytics_page/analytics_info_card.dart';
import 'package:sweep_host/pages/analytics_page/bento_flame.dart';
import 'package:sweep_host/pages/analytics_page/post_peek_chart.dart';
import 'package:sweep_host/pages/analytics_page/user_ranking_chart.dart';
import 'package:sweep_host/pages/dashboard_page/post_data_chart.dart';
import 'package:sweep_host/states/discard_strasm_provider.dart';
import 'package:sweep_host/states/post_stream_provider.dart';
import 'package:sweep_host/states/trashbox_stream_provider.dart';
import 'package:sweep_host/states/user_stream_provider.dart';

part 'discard_count_info_card.dart';
part 'post_count_info_card.dart';
part 'trashBox_count_info_card.dart';
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
          userCount postCount trashBoxCount trashBoxCount discardCount
          post post post peek peek
          user user user user user 
        ''',

        columnSizes: [1.0.fr, 1.0.fr, 0.6.fr, 0.4.fr, 1.0.fr],
        rowSizes: [0.6.fr, 2.4.fr, 1.2.fr],
        children: [
          gridArea("userCount").containing(
            BentoFlame(
              child: UserCountInfoCard(
                errorWidget: errorWidget,
                loadingWidget: loadingWidget,
              ),
            ),
          ),
          gridArea("postCount").containing(
            BentoFlame(
              child: PostCountInfoCard(
                errorWidget: errorWidget,
                loadingWidget: loadingWidget,
              ),
            ),
          ),
          gridArea("trashBoxCount").containing(
            BentoFlame(
              child: TrashboxCountInfoCard(
                errorWidget: errorWidget,
                loadingWidget: loadingWidget,
              ),
            ),
          ),
          gridArea("discardCount").containing(
            BentoFlame(
              child: DiscardCountInfoCard(
                errorWidget: errorWidget,
                loadingWidget: loadingWidget,
              ),
            ),
          ),
          gridArea("post").containing(BentoFlame(child: PostDataChart())),
          gridArea("peek").containing(BentoFlame(child: PostPeekChart())),
          gridArea("user").containing(BentoFlame(child: UserRankingChart())),
        ],
      ),
    );
  }
}
