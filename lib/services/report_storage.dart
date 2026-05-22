import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/report_model.dart';

class ReportStorage {
  static const String key = "patient_reports";

  /// Load Reports
  static Future<List<Report>> loadReports() async {
    final prefs = await SharedPreferences.getInstance();

    List<String>? data = prefs.getStringList(key);

    if (data == null) return [];

    return data.map((e) => Report.fromJson(jsonDecode(e))).toList();
  }

  /// Save Reports
  static Future<void> saveReports(List<Report> reports) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> data = reports.map((e) => jsonEncode(e.toJson())).toList();

    await prefs.setStringList(key, data);
  }

  /// Add New Report
  static Future<void> addReport(Report report) async {
    List<Report> reports = await loadReports();

    reports.add(report);

    await saveReports(reports);
  }
}
