// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:sweep_host/classes/post.dart';

class TrashMakerChild extends HookConsumerWidget {
  const TrashMakerChild({super.key, required this.type});

  final PostType type;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SvgPicture.asset("assets/images/markers/${type.name}.svg"),
    );
  }
}
