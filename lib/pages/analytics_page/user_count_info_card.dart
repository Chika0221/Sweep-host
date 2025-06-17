part of 'analytics_page.dart';

class UserCountInfoCard extends HookConsumerWidget {
  const UserCountInfoCard({
    super.key,
    required this.errorWidget,
    required this.loadingWidget,
  });

  final Widget Function() loadingWidget;
  final Widget Function(Object, StackTrace) errorWidget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStream = ref.watch(userStreamProvider);

    return userStream.when(
      data: (data) {
        return AnalyticsInfoCard(
          propertie: "ユーザー数",
          value: data.length.toString(),
          leadingIcon: Icons.people_rounded,
          accentColor: Colors.purpleAccent,
          onTap:
              () => showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("ユーザー"),
                    content: SizedBox(
                      height: double.maxFinite,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: ListView.separated(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.surfaceContainerHighest,
                            ),
                            child: ListTile(
                              title: Text(data[index].displayName),
                              subtitle: Text(
                                "今週のポイント：${data[index].cumulativePoint}",
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 4);
                        },
                      ),
                    ),
                  );
                },
              ),
        );
      },
      error: errorWidget,
      loading: loadingWidget,
    );
  }
}
