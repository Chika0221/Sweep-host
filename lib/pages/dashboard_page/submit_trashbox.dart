// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SubmitTrashboxButton extends HookConsumerWidget {
  const SubmitTrashboxButton({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 100,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Center(
        child: Text(
          "ゴミ箱を追加", 
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
    );
  }
}
