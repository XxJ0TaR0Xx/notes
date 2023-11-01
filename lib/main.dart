import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:notes/core/firebase/firebase_module.dart';
import 'package:notes/core/services/services.dart';
import 'package:notes/src/presentation/app.dart';
import 'package:uuid/uuid.dart';

//! WORKS ON WEB COUSE OF ANDROID DEPENDENCIES. FIX IT

FutureOr<void> firebaseTest(String id) async {
  log('DEBUG: ID - $id');
  await FirebaseFirestore.instance.collection('debug').add({
    'doc': id,
  }).then(
    (value) {
      log('DEBUG: SUCCESS');
    },
  ).onError((error, stackTrace) {
    log('DEBUG: ERR - ${error.toString()}');
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // services related
  await initializeDateFormatting('ru_RU', null);
  await initServices();

  // firebase related
  await services<FirebaseModule>().init();

  // final String v4ID = const Uuid().v4();
  // firebaseTest(v4ID);

  runApp(const App());
}
