// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:sweep_host/classes/trash_box.dart';

final trashBoxStreamProvider = StreamProvider.autoDispose<List<TrashBox>>((
  ref,
) {
  final collection = FirebaseFirestore.instance.collection("trashBox");

  final stream = collection.snapshots().map((e) {
    return e.docs.map((e) => TrashBox.fromJson(e.data())).toList();
  });

  return stream;
});
