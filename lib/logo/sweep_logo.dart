// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SweepLogo extends HookConsumerWidget {
  const SweepLogo({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 200,
      child: Center(
        child: Text("Sweep!", style: Theme.of(context).textTheme.headlineLarge,),
      ),
    );
  }
}
