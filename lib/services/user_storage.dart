import 'dart:convert';
import 'package:pregmaa/model/pregnancy_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserStorage {
  static const String userKey = "pregnancy_user";

  static Future<void> saveUser(PregnancyUser user) async {
    final prefs = await SharedPreferences.getInstance();

    String jsonData = jsonEncode(user.toJson());

    await prefs.setString(userKey, jsonData);
  }

  static Future<PregnancyUser?> getUser() async {
    final prefs = await SharedPreferences.getInstance();

    String? jsonData = prefs.getString(userKey);

    if (jsonData == null) return null;

    return PregnancyUser.fromJson(jsonDecode(jsonData));
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(userKey);
  }
}
