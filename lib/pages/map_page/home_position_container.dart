// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePositionContainer extends HookConsumerWidget {
  const HomePositionContainer({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Center(child: Icon(Icons.home_rounded)),
    );
  }
}
