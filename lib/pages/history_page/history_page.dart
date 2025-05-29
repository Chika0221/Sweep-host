// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HistoryPage extends HookConsumerWidget {
  const HistoryPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Row(
        children: [
          Flexible(flex: 2,child: Container(color: Colors.amber,)),
          Flexible(flex: 1,child: Container(color: Colors.blue,)),
        ],
      ),
    );
  }
}
