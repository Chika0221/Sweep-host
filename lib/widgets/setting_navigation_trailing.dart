// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingNavigationTrailing extends HookConsumerWidget {
  const SettingNavigationTrailing({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [CircleAvatar(), Text("名前")],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [Icon(Icons.settings_rounded), Text("設定")],
        ),
      ],
    );
  }
}
