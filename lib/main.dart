// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:sweep_host/pages/main_page.dart';

void main() {
  final app = MyApp();
  final providerScope = ProviderScope(child: app);
  runApp(providerScope);
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      // darkTheme: ThemeData.dark(),
      theme: ThemeData(colorSchemeSeed: Colors.blue),
      home: MainPage(),
    );
  }
}
