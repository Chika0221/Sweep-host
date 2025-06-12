// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:sweep_host/classes/host.dart';
import 'package:sweep_host/states/login_notifier.dart';

final hostProvider = StateProvider<Host?>((ref) {
  final hostId = ref.watch(loginProvider);
  FirebaseFirestore.instance.collection("host").doc(hostId).get().then((
    snapshot,
  ) {
    if (snapshot.exists) {
      return Host.fromJson(snapshot.data()!);
    } else {
      return null;
    }
  });
});
