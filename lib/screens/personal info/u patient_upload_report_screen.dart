import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../model/report_model.dart';
import '../../services/report_storage.dart';

class patientUploadReportScreen extends StatefulWidget {
  const patientUploadReportScreen({super.key});

  @override
  State<patientUploadReportScreen> createState() =>
      _patientUploadReportScreenState();
}

class _patientUploadReportScreenState extends State<patientUploadReportScreen> {
  File? selectedFile;

  String fileType = "";

  final titleController = TextEditingController();

  pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      selectedFile = File(result.files.single.path!);

      fileType = result.files.single.extension ?? "";

      setState(() {});
    }
  }

  saveReport() async {
    if (selectedFile == null || titleController.text.isEmpty) return;

    Report report = Report(
      id: DateTime.now().millisecondsSinceEpoch.toString(),

      title: titleController.text,

      fileUrl: selectedFile!.path,

      fileType: fileType,

      date: DateTime.now().toString(),

      doctorSuggestion: "",
    );

    await ReportStorage.addReport(report);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload Report")),

      body: Padding(
        padding: EdgeInsets.all(16),

        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Report Title"),
            ),

            SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: pickFile,
              icon: Icon(Icons.upload_file),
              label: Text("Select File"),
            ),

            SizedBox(height: 20),

            ElevatedButton(onPressed: saveReport, child: Text("Save Report")),
          ],
        ),
      ),
    );
  }
}
