import 'package:notes/core/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

//TODO: shared pref => injector
//@Singleton()
class UserDatasourse {
  final String _keyUserId = 'userId';

  // Сохранение userId в SharedPreferences
  SharedPref sharedPref = services<SharedPref>();

  Future<void> saveUserId(String userId) async {
    SharedPreferences prefs = await sharedPref.prefs;
    await prefs.setString(_keyUserId, userId);
  }

  // Получение userId из SharedPreferences
  Future<String?> getUserId() async {
    SharedPreferences prefs = await sharedPref.prefs;
    return prefs.getString(_keyUserId);
  }

  // Удаление userId из SharedPreferences
  Future<void> removeUserId() async {
    SharedPreferences prefs = await sharedPref.prefs;
    await prefs.remove(_keyUserId);
  }
}
