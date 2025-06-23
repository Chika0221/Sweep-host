// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:sweep_host/classes/discard.dart';

final discardStreamProvider = StreamProvider.autoDispose<List<Discard>>((
  ref,
) {
  final collection = FirebaseFirestore.instance.collection("discard");

  final stream = collection.snapshots().map((e) {
    return e.docs.map((e) => Discard.fromJson(e.data())).toList();
  });

  return stream;
});
