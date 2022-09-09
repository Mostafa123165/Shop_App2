import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic getDate({
    required String key,
  }) {
    return sharedPreferences.get(key);
  }

  static Future<bool> saveData({
    required String key,
    required dynamic val,
  }) async {
    if (val is bool) return await sharedPreferences.setBool(key, val);
    if (val is int) return await sharedPreferences.setInt(key, val);
    if (val is String) return await sharedPreferences.setString(key, val);
    return await sharedPreferences.setDouble(key, val);
  }

  Future<bool> removeDate({
    required String key,
  }) async {
    return await sharedPreferences.remove(key);
  }
}
