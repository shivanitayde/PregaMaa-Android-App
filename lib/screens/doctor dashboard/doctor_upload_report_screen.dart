import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

import '../../../model/report_model.dart';
import '../../../model/patient_model.dart';

class UploadReportScreen extends StatefulWidget {
  final Patient patient;

  const UploadReportScreen({super.key, required this.patient});

  @override
  State<UploadReportScreen> createState() => _UploadReportScreenState();
}

class _UploadReportScreenState extends State<UploadReportScreen> {
  File? selectedFile;

  String fileType = "";

  final titleController = TextEditingController();

  /// Pick PDF

  pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);

        fileType = "pdf";
      });
    }
  }

  /// Pick Image

  pickImage() async {
    final picker = ImagePicker();

    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedFile = File(image.path);

        fileType = "image";
      });
    }
  }

  /// Save Report

  saveReport() {
    if (selectedFile == null || titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Select file & enter title")),
      );

      return;
    }

    widget.patient.reports.add(
      Report(
        id: DateTime.now().millisecondsSinceEpoch.toString(),

        title: titleController.text,

        fileUrl: selectedFile!.path,

        fileType: fileType,

        date: DateTime.now().toString(),

        doctorSuggestion: "",
      ),
    );

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Report Uploaded")));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload Report")),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            /// Title
            TextField(
              controller: titleController,

              decoration: const InputDecoration(labelText: "Report Title"),
            ),

            const SizedBox(height: 20),

            /// Pick Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: pickPDF,
                    icon: const Icon(Icons.picture_as_pdf),
                    label: const Text("PDF"),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: pickImage,
                    icon: const Icon(Icons.image),
                    label: const Text("Image"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// Preview
            if (selectedFile != null)
              Column(
                children: [
                  if (fileType == "image")
                    Image.file(selectedFile!, height: 150),

                  if (fileType == "pdf")
                    const Icon(
                      Icons.picture_as_pdf,
                      size: 80,
                      color: Colors.red,
                    ),
                ],
              ),

            const Spacer(),

            /// Save Button
            ElevatedButton(
              onPressed: saveReport,
              child: const Text("Save Report"),
            ),
          ],
        ),
      ),
    );
  }
}
