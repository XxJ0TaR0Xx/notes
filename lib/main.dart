import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:notes/core/firebase/firebase_module.dart';
import 'package:notes/core/services/services.dart';
import 'package:notes/src/presentation/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // services related
  await initializeDateFormatting('ru_RU', null);
  await initServices();

  // firebase related
  await services<FirebaseModule>().init();

  runApp(const App());
}
