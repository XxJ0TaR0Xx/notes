import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:notes/presentation/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('ru_RU', null);

  runApp(const App());
}
