// Dart imports:
import 'dart:async';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:sweep_host/classes/profile.dart';

// Project imports:


final getUsersProvider =
    AutoDisposeAsyncNotifierProvider<GetUsersNotifier, List<Profile>>(
  GetUsersNotifier.new,
);

class GetUsersNotifier extends AutoDisposeAsyncNotifier<List<Profile>> {
  @override
  FutureOr<List<Profile>> build() async {
    return _fetchUsers();
  }

  Future<List<Profile>> _fetchUsers() async {
    try {
      final collection = FirebaseFirestore.instance.collection("user");
      final querySnapshot = await collection.get();
      final users = querySnapshot.docs
          .map((doc) => Profile.fromJson(doc.data()))
          .toList();
      state = AsyncValue.data(users);
      return users;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return [];
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final users = await _fetchUsers();
      state = AsyncValue.data(users);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

// final userStreamProvider = StreamProvider.autoDispose<List<Profile>>((ref) {
//   final collection = FirebaseFirestore.instance.collection("user");

//   final stream =
//       collection.snapshots().map((e) {
//     return e.docs.map((e) => Profile.fromJson(e.data())).toList();
//   });

//   return stream;
// });
