// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';

// Project imports:
import 'package:sweep_host/pages/dashboard_page/trashbox_state_list_view_item.dart';
import 'package:sweep_host/states/trashbox_stream_provider.dart';

class TrashboxStateListView extends HookConsumerWidget {
  const TrashboxStateListView({super.key, required this.onItemTap});

  final void Function(LatLng location) onItemTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trashBoxData = ref.watch(trashBoxStreamProvider);

    return trashBoxData.when(
      data: (trashBoxs) {
        if (trashBoxs.isEmpty) {
          return Center(child: Text("データが見つかりません"));
        }

        return ListView.separated(
          itemCount: trashBoxs.length,
          itemBuilder: (context, index) {
            return TrashboxStateListViewItem(
              trashBox: trashBoxs[index],
              onTap: onItemTap,
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        );
      },
      error: (error, stackTrace) {
        return Center(child: Text("読み込みエラー"));
      },
      loading: () {
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
