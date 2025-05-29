// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_network/image_network.dart';

// Project imports:
import 'package:sweep_host/classes/post.dart';
import 'package:sweep_host/classes/profile.dart';
import 'package:sweep_host/pages/history_page/map_box.dart';
import 'package:sweep_host/states/user_stream_provider.dart';

class PostDetailContainer extends HookConsumerWidget {
  const PostDetailContainer({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    post.comment,
                    style: Theme.of(context).textTheme.headlineSmall,
                    overflow: TextOverflow.ellipsis,
                    // softWrap: true,
                    maxLines: 1000,
                  ),
                ),
                Divider(),
              ],
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CarouselView.weighted(
              flexWeights: [1, 1, 1],
              scrollDirection: Axis.horizontal,
              children: List.generate(post.imagePaths.length, (index) {
                return ImageNetwork(
                  image: post.imagePaths[index],
                  height: 400,
                  width: 300,
                );
              }),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: Icon(Icons.label_outline_rounded),
                        title: Text(post.postId),
                      ),
                      ListTile(
                        leading: Icon(Icons.person_rounded),
                        title: Text(post.uid),
                      ),
                      ListTile(
                        leading: Icon(Icons.access_time_rounded),
                        title: Text(post.time.toString()),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Chip(label: Text(post.type.displayName)),
                          SizedBox(width: 4),
                          Chip(
                            label: Text(post.nice.toString()),
                            avatar: Icon(Icons.favorite_rounded),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: MapBox(location: post.location, type: post.type),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
