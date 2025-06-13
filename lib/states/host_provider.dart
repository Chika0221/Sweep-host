// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:sweep_host/classes/host.dart';
import 'package:sweep_host/states/login_notifier.dart';

final hostProvider = StreamProvider<Host>((ref) {
  final hostId = ref.watch(loginProvider);
  final stream = FirebaseFirestore.instance
      .collection("host")
      .doc(hostId)
      .snapshots()
      .map((snapshot) {
        return Host.fromJson(snapshot.data()!);
      });
  return stream;
});
