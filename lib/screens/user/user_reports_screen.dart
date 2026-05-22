import 'package:flutter/material.dart';
import 'package:pregmaa/screens/doctor dashboard/doctor_upload_report_screen.dart';
import 'package:pregmaa/screens/report_view_screen.dart';

import '../../model/report_model.dart';
import '../../model/patient_model.dart'; // ✅ NEW
import '../../services/report_storage.dart';

class UserReportsScreen extends StatefulWidget {
  // ✅ RECEIVE PATIENT
  final Patient patient;

  const UserReportsScreen({super.key, required this.patient});

  @override
  State<UserReportsScreen> createState() => _UserReportsScreenState();
}

class _UserReportsScreenState extends State<UserReportsScreen> {
  List<Report> reports = [];

  @override
  void initState() {
    super.initState();
    loadReports();
  }

  /// Load Reports
  Future<void> loadReports() async {
    reports = await ReportStorage.loadReports();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Reports")),

      /// Upload Button
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.upload),

        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => UploadReportScreen(
                patient: widget.patient, // ✅ FIXED
              ),
            ),
          ).then((_) {
            loadReports(); // refresh list
          });
        },
      ),

      body: reports.isEmpty
          ? const Center(child: Text("No Reports Uploaded"))
          : ListView.builder(
              itemCount: reports.length,

              itemBuilder: (context, index) {
                final report = reports[index];

                return Card(
                  margin: const EdgeInsets.all(10),

                  child: ListTile(
                    leading: Icon(
                      report.fileType == "pdf"
                          ? Icons.picture_as_pdf
                          : Icons.image,

                      color: Colors.red,
                    ),

                    title: Text(report.title),

                    subtitle: Text(report.date),

                    /// OPEN REPORT
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ReportViewScreen(report: report),
                        ),
                      ).then((_) {
                        loadReports();
                      });
                    },
                  ),
                );
              },
            ),
    );
  }
}
