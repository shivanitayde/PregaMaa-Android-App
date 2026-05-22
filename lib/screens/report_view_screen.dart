import 'package:flutter/material.dart';
import '../model/report_model.dart';

class ReportViewScreen extends StatefulWidget {
  final Report report;

  const ReportViewScreen({super.key, required this.report});

  @override
  State<ReportViewScreen> createState() => _ReportViewScreenState();
}

class _ReportViewScreenState extends State<ReportViewScreen> {
  late TextEditingController suggestionController;

  @override
  void initState() {
    suggestionController = TextEditingController(
      text: widget.report.doctorSuggestion,
    );

    super.initState();
  }

  saveSuggestion() {
    setState(() {
      widget.report.doctorSuggestion = suggestionController.text;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Suggestion Saved")));
  }

  @override
  Widget build(BuildContext context) {
    final report = widget.report;

    return Scaffold(
      appBar: AppBar(title: Text(report.title)),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            /// Report Viewer Placeholder
            Container(
              height: 200,
              color: Colors.grey.shade200,
              child: const Center(child: Text("Report Preview Here")),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: suggestionController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: "Doctor Suggestion",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: saveSuggestion,
              child: const Text("Save Suggestion"),
            ),
          ],
        ),
      ),
    );
  }
}
