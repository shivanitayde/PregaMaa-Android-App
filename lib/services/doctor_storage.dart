import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/doctor_model.dart';

class DoctorStorage {
  static const String key = "user_doctor";

  /// Save Doctor
  static Future<void> saveDoctor(Doctor doctor) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(key, jsonEncode(doctor.toJson()));
  }

  /// Load Doctor
  static Future<Doctor?> loadDoctor() async {
    final prefs = await SharedPreferences.getInstance();

    String? data = prefs.getString(key);

    if (data == null) return null;

    return Doctor.fromJson(jsonDecode(data));
  }
}
