// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:sweep_host/pages/dashboard_page/host_plate.dart';
import 'package:sweep_host/pages/dashboard_page/info_plate_item.dart';
import 'package:sweep_host/states/get_discards_provider.dart';
import 'package:sweep_host/states/post_stream_provider.dart';
import 'package:sweep_host/states/trashbox_stream_provider.dart';
import 'package:sweep_host/states/user_stream_provider.dart';

class InfoPlate extends HookConsumerWidget {
  const InfoPlate({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postStream = ref.watch(postStreamProvider);
    final userStream = ref.watch(userStreamProvider);
    final trashBoxStream = ref.watch(trashBoxStreamProvider);
    final discardFuture = ref.watch(getDiscardsProvider);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "今日も元気にLet's Sweep",
            style: Theme.of(
              context,
            ).textTheme.displayLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              userStream.when(
                data: (users) {
                  return InfoPlateItem(
                    icon: Icons.people_rounded,
                    title: "ユーザー数",
                    value: users.length.toString(),
                  );
                },
                error: (error, stack) {
                  return InfoPlateItem(
                    icon: Icons.error,
                    title: "ユーザー数",
                    value: "エラー",
                  );
                },
                loading: () => CircularProgressIndicator(),
              ),
              postStream.when(
                data: (posts) {
                  return InfoPlateItem(
                    icon: Icons.delete_sweep_rounded,
                    title: "ゴミ投稿数",
                    value: posts.length.toString(),
                  );
                },
                error: (error, stack) {
                  return InfoPlateItem(
                    icon: Icons.error,
                    title: "投稿数　　",
                    value: "エラー",
                  );
                },
                loading: () => CircularProgressIndicator(),
              ),
              trashBoxStream.when(
                data: (trashBoxes) {
                  return InfoPlateItem(
                    icon: Icons.delete_rounded,
                    title: "ゴミ箱数　",
                    value: trashBoxes.length.toString(),
                  );
                },
                error: (error, stack) {
                  return InfoPlateItem(
                    icon: Icons.error,
                    title: "ゴミ箱数　",
                    value: "エラー",
                  );
                },
                loading: () => CircularProgressIndicator(),
              ),
              discardFuture.when(
                data: (discards) {
                  return InfoPlateItem(
                    icon: Icons.delete_forever_rounded,
                    title: "ゴミ捨て数",
                    value: discards.length.toString(),
                  );
                },
                error: (error, stack) {
                  return InfoPlateItem(
                    icon: Icons.error,
                    title: "ゴミ捨て数",
                    value: "エラー",
                  );
                },
                loading: () => CircularProgressIndicator(),
              ),
            ],
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
