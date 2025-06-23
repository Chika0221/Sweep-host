part of 'analytics_page.dart';

class DiscardCountInfoCard extends HookConsumerWidget {
  const DiscardCountInfoCard({
    super.key,
    required this.errorWidget,
    required this.loadingWidget,
  });

  final Widget Function(Object, StackTrace) errorWidget;
  final Widget Function() loadingWidget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final discardStream = ref.watch(discardStreamProvider);

    return discardStream.when(
      data: (data) {
        return AnalyticsInfoCard(
          propertie: "ゴミ捨て数",
          value: data.length.toString(),
          leadingIcon: Icons.delete_forever_rounded,
          accentColor: Colors.teal,
          onTap:
              () => showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("ゴミ捨て"),
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
                              title: Text(data[index].time.toString()),
                              subtitle: Text("ゴミの重さ：${data[index].weight}g"),
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
