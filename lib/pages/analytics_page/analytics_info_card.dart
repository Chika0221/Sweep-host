// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:sweep_host/pages/analytics_page/info_icon.dart';

class AnalyticsInfoCard extends HookConsumerWidget {
  const AnalyticsInfoCard({
    super.key,
    required this.propertie,
    required this.value,
    required this.leadingIcon,
    required this.accentColor,
    required this.onTap,
  });

  final String propertie;
  final String value;
  final IconData leadingIcon;
  final Color accentColor;
  final void Function() onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      onTap: onTap,
      leading: InfoIcon(
        icon: leadingIcon,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        foregroundColor: accentColor,
      ),
      title: Text(propertie),
      subtitle: Text(value),
      trailing: Icon(Icons.arrow_drop_down),
    );
  }
}
