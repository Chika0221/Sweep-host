// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:sweep_host/classes/trash_box.dart';

class TrashboxStateIndicator extends HookConsumerWidget {
  const TrashboxStateIndicator({super.key, required this.trashBox});

  final TrashBox trashBox;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = trashBox.weight / trashBox.maxWeight;
    late Color backColor;

    if (value > 0.8) {
      backColor = Colors.red;
    } else if (value > 0.5) {
      backColor = Colors.yellow;
    } else {
      backColor = Colors.green;
    }

    return LinearProgressIndicator(
      borderRadius: BorderRadius.circular(100),
      color: backColor,
      value: value,
    );
  }
}
