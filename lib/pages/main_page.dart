// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:sweep_host/logo/sweep_logo.dart';
import 'package:sweep_host/pages/analytics_page.dart';
import 'package:sweep_host/pages/dashboard_page/dashboard_page.dart';
import 'package:sweep_host/pages/history_page/history_page.dart';
import 'package:sweep_host/pages/map_page/map_page.dart';
import 'package:sweep_host/widgets/setting_navigation_trailing.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationSelected = useState(0);
    final navigationOpen = useState(false);

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: navigationSelected.value,
            useIndicator: true,
            onDestinationSelected: (value) {
              navigationSelected.value = value;
            },
            labelType: NavigationRailLabelType.none,
            extended: navigationOpen.value,
            leading: Column(
              children: [
                IconButton(
                  onPressed: () {
                    navigationOpen.value = !navigationOpen.value;
                  },
                  icon: Icon(Icons.menu_rounded),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  width: (navigationOpen.value) ? 200 : 100,
                  child: Image.asset(
                    "assets/icons/icon_android_foreground.png",
                    width: 200,
                  ),
                ),
              ],
            ),
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard_rounded),
                label: Text("ダッシュボード"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.map_rounded),
                label: Text("マップ"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.history_rounded),
                label: Text("投稿履歴"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.analytics_rounded),
                label: Text("分析"),
              ),
            ],
          ),
          Expanded(
            child: IndexedStack(
              index: navigationSelected.value,
              children: const [
                DashboardPage(),
                MapPage(),
                HistoryPage(),
                AnalyticsPage(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
