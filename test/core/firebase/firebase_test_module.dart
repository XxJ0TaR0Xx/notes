import 'dart:async';
import 'dart:io';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:notes/core/firebase/firebase_module.dart';

extension FirebaseTestModule on FirebaseModule {
  FutureOr<void> initTest() async {
    final File firebaseRules = File('test/core/firebase/firebase.rules');
    if (!await firebaseRules.exists()) throw Exception('required \'firebase.rules\'file does\'t exist');
    firebaseFirestore = FakeFirebaseFirestore(
      securityRules: await firebaseRules.readAsString(),
    );
  }
}
