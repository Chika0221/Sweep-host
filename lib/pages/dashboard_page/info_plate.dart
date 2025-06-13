// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:sweep_host/pages/dashboard_page/host_plate.dart';

class InfoPlate extends HookConsumerWidget {
  const InfoPlate({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "今日も元気にLet's Sweep",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Align(alignment: Alignment.topRight, child: HostPlate()),
        ],
      ),
    );
  }
}
