// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(child: Container(color: Colors.red)),
        Container(
          transform: Matrix4.rotationZ(90 * pi / 180),
          transformAlignment: Alignment.center,
          width: 50,
          height: double.infinity,
          child: Icon(Icons.arrow_upward),
        ),
        Expanded(child: Container(color: Colors.blue)),
      ],
    );
  }
}
