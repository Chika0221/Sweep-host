part of 'analytics_page.dart';

class PostCountInfoCard extends HookConsumerWidget {
  const PostCountInfoCard({
    super.key,
    required this.errorWidget,
    required this.loadingWidget,
  });

  final Widget Function(Object, StackTrace) errorWidget;
  final Widget Function() loadingWidget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postStream = ref.watch(postStreamProvider);

    return postStream.when(
      data: (data) {
        return AnalyticsInfoCard(
          propertie: "ゴミ総投稿数",
          value: data.length.toString(),
          leadingIcon: Icons.delete_sweep_rounded,
          accentColor: Colors.blue,
          onTap: null,
        );
      },
      error: errorWidget,
      loading: loadingWidget,
    );
  }
}
