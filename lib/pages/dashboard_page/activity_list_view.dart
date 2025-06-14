// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:sweep_host/classes/trash_box.dart';
import 'package:sweep_host/states/get_discards_provider.dart';
import 'package:sweep_host/states/post_stream_provider.dart';
import 'package:sweep_host/states/trashbox_stream_provider.dart';
import 'package:sweep_host/states/user_stream_provider.dart';

class ActivityListView extends HookConsumerWidget {
  const ActivityListView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postStream = ref.watch(postStreamProvider);
    // final userStream = ref.watch(userStreamProvider);
    // final trashBoxStream = ref.watch(trashBoxStreamProvider);
    final discardFuture = ref.watch(getDiscardsProvider);

    return Container(color: Colors.red);
    return postStream.when(
      data: (posts) {
        return discardFuture.when(
          data: (discards) {
            // final dataList = [...posts, ...discards];

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final data = posts[index];
                  return ActivityListViewItem(data: data);
                },
              ),
            );
          },
          error:
              (error, stack) =>
                  Center(child: Text("Error fetching discards: $error")),
          loading: () => Center(child: CircularProgressIndicator()),
        );
      },
      error: (error, stack) => Center(child: Text("Error: $error")),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}

class ActivityListViewItem extends HookConsumerWidget {
  const ActivityListViewItem({super.key, required this.data});

  final dynamic data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 100,
      width: double.infinity,
      child: Center(
        child: Text(
          data is TrashBox ? "Trash Box: ${data.name}" : "Post: ${data.title}",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
