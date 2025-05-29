// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:sweep_host/classes/post.dart';
import 'package:sweep_host/states/post_stream_provider.dart';

class HistoryList extends HookConsumerWidget {
  const HistoryList({super.key, required this.onTileTap});

  final void Function(Post post) onTileTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postData = ref.watch(postStreamProvider);

    return Padding(
      padding: EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                color: Theme.of(context).colorScheme.surfaceContainerLow,
              ),
              height: 75,
            ),
            Expanded(
              child: postData.when(
                data: (data) {
                  return ListView.separated(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final post = data[index];
                      return ListTile(
                        onTap: () => onTileTap(post),
                        title: Text(post.comment),
                        subtitle: Text(post.time.toString().split(".")[0]),
                      );
                    },
                    separatorBuilder: (contxet, index) {
                      return Divider();
                    },
                  );
                },
                error: (error, stackTrace) {
                  return Center(child: Text("読み込みエラー"));
                },
                loading: () {
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
