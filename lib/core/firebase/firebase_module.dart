import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';
import 'package:notes/core/firebase/firebase_options.dart';

@Singleton()
class FirebaseModule {
  late final FirebaseApp firebaseApp;
  late final FirebaseFirestore firebaseFirestore;
  late final FirebaseAuth auth;

  FutureOr<void> init() async {
    firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    firebaseFirestore = FirebaseFirestore.instance;

    auth = FirebaseAuth.instanceFor(app: firebaseApp);
  }
}
