import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:notes/core/services/services.config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'services.config.dart';

final GetIt services = GetIt.I;

@InjectableInit(initializerName: 'generate')
FutureOr<void> initServices() {
  services.generate();
}

@injectable
class SharedPref {
  Future<SharedPreferences> get prefs async => await SharedPreferences.getInstance();
}
