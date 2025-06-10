// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:sweep_host/classes/post.dart';
import 'package:sweep_host/pages/history_page/history_list.dart';
import 'package:sweep_host/pages/history_page/post_detail_container.dart';

class HistoryPage extends HookConsumerWidget {
  const HistoryPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<Post?> focusPost = useState(null);

    return Expanded(
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: Center(
              child:
                  (focusPost.value != null)
                      ? PostDetailContainer(post: focusPost.value!)
                      : Text("投稿を選択してください"),
            ),
          ),
          Flexible(
            flex: 1,
            child: HistoryList(
              onTileTap: (post) async {
                focusPost.value = null;
                await Future.delayed(Duration(milliseconds: 1));
                focusPost.value = post;
              },
            ),
          ),
        ],
      ),
    );
  }
}
