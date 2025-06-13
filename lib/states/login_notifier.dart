// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:sweep_host/classes/host.dart';

class LoginNotifier extends Notifier<String> {
  @override
  String build() {
    return "";
  }

  void setState(String newState) {
    state = newState;
  }

  Future<String> signInWIthEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final User newUser = userCredential.user!;
      await FirebaseFirestore.instance
          .collection("host")
          .where("email", isEqualTo: email)
          .get()
          .then((QuerySnapshot snapshot) {
            final data = snapshot.docs[0];
            state = data.get("hid").toString();
          });
      state = newUser.uid;
      return "";
    } catch (e) {
      return "$e";
    }
  }

  Future<String> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      state = userCredential.user!.uid;
      return "";
    } catch (e) {
      return "$e";
    }
  }
}

final loginProvider = NotifierProvider<LoginNotifier, String>(
  LoginNotifier.new,
);
