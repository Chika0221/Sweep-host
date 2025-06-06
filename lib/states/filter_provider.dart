// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:sweep_host/classes/post.dart';

// Project imports:


final filterProvider = StateProvider<Set<PostType>>((ref) {
  return {PostType.trash, PostType.trashCan, PostType.trashBox};
});
