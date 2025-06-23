part of 'analytics_page.dart';

class TrashboxCountInfoCard extends HookConsumerWidget {
  const TrashboxCountInfoCard({
    super.key,
    required this.errorWidget,
    required this.loadingWidget,
  });

  final Widget Function(Object, StackTrace) errorWidget;
  final Widget Function() loadingWidget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trashBoxStream = ref.watch(trashBoxStreamProvider);

    return trashBoxStream.when(
      data: (data) {
        return AnalyticsInfoCard(
          propertie: "ゴミ箱数",
          value: data.length.toString(),
          leadingIcon: Icons.delete_rounded,
          accentColor: Colors.brown,
          onTap:
              () => showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("ゴミ箱"),
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
                              title: Text(data[index].name),
                              subtitle: Text(
                                "最大容量：${data[index].maxWeight / 1000}kg",
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
