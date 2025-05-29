// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_network/image_network.dart';

// Project imports:
import 'package:sweep_host/classes/post.dart';

class PostItem extends HookConsumerWidget {
  const PostItem({super.key, required this.post, this.showNiceButton = true});

  final Post post;
  final bool showNiceButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tapNice = useState(false);

    return Container(
      width: post.imagePaths.length * 400,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // コメントを表示
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  post.comment,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              SizedBox(width: 8),
              Chip(label: Text(post.type.displayName)),
            ],
          ),
          const SizedBox(height: 16.0),
          // 画像を表示 (Firebase StorageのURLを使用)
          (post.imagePaths.isNotEmpty)
              ? SizedBox(
                height: 400,
                width: double.infinity,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: post.imagePaths.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Flexible(
                        flex: post.imagePaths.length,
                        child: ImageNetwork(
                          image: post.imagePaths[index], // 最初の画像を表示
                          width: 300,
                          height: 400,
                          fitWeb: BoxFitWeb.cover,
                          onLoading: CircularProgressIndicator(),
                          onError: SizedBox(child: Text("エラー")),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 4);
                  },
                ),
              )
              : const SizedBox(height: 12.0),
          SizedBox(height: 16),
          // 投稿日時やいいね数などを表示 (必要に応じて追加)
          Text(
            '${post.time.toString().split(' ')[0]} ${post.time.toString().split(' ')[1].split(".")[0]}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
