// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:timeline_tile/timeline_tile.dart';

// Project imports:
import 'package:sweep_host/classes/trash_box.dart';
import 'package:sweep_host/pages/dashboard_page/trashbox_state_list_view_item.dart';
import 'package:sweep_host/states/trashbox_stream_provider.dart';

class CreateRouteList extends HookConsumerWidget {
  const CreateRouteList({super.key, required this.onUpdate});

  final void Function(List<TrashBox>) onUpdate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trashBoxStream = ref.watch(trashBoxStreamProvider);
    final wayPoints = useState<List<LatLng>>([]);

    return trashBoxStream.when(
      data: (data) {
        onUpdate(data);

        wayPoints.value = data.map((trashBox) => trashBox.location).toList();

        return ReorderableListView.builder(
          itemCount: wayPoints.value.length,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Container(
                key: Key(index.toString()),
                height: 64,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: Center(
                  child: Text(
                    "スタート",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ),
              );
            } else if (wayPoints.value.length - 1 == index) {
              return Container(
                key: Key(index.toString()),
                height: 64,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: Center(
                  child: Text(
                    "ゴール",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ),
              );
            }
            return Padding(
              key: Key(index.toString()),
              padding: const EdgeInsets.only(left: 16),
              child: TimelineTile(
                indicatorStyle: IndicatorStyle(
                  width: 12,
                  indicator: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
                beforeLineStyle: LineStyle(
                  thickness: 4,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                alignment: TimelineAlign.start,
                endChild: Padding(
                  padding: EdgeInsets.fromLTRB(4, 4, 0, 4),
                  child: TrashboxStateListViewItem(
                    trashBox: TrashBox(
                      name: "名前",
                      trashBoxId: "a",
                      location: LatLng(1, 1),
                      maxWeight: 1000,
                    ),
                    onTap: (location) {},
                  ),
                ),
              ),
            );
          },
          onReorder: (oldIndex, newIndex) {
            print("${oldIndex} : ${newIndex}");
          },
        );
      },
      error: (error, stackTrace) {
        return Center(child: Text("エラー：$error"));
      },
      loading: () {
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
