// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';

// Project imports:
import 'package:sweep_host/classes/trash_box.dart';
import 'package:sweep_host/pages/dashboard_page/trashbox_state_Indicator.dart';

class TrashboxStateListViewItem extends HookConsumerWidget {
  const TrashboxStateListViewItem({
    super.key,
    required this.trashBox,
    required this.onTap,
  });

  final TrashBox trashBox;
  final void Function(LatLng location) onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () => onTap(trashBox.location),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              trashBox.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 16),
            SizedBox(height: 16),
            TrashboxStateIndicator(trashBox: trashBox),
          ],
        ),
      ),
    );
  }
}
