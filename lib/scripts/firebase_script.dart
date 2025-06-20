// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:sweep_host/classes/trash_box.dart';

class FirebaseScript {
  Future<void> addTrashbox(TrashBox trashbox) async {
    await FirebaseFirestore.instance
        .collection("trashBox")
        .doc(trashbox.trashBoxId)
        .set(trashbox.toJson());
  }
}
