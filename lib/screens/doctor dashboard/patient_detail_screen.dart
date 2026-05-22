import 'package:flutter/material.dart';
import 'package:pregmaa/model/patient_model.dart';
import 'package:pregmaa/model/report_model.dart';
import 'package:pregmaa/screens/report_view_screen.dart';
import 'package:pregmaa/screens/doctor%20dashboard/doctor_upload_report_screen.dart';
import 'package:pregmaa/services/report_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class PatientDetailScreen extends StatefulWidget {
  final Patient patient;

  const PatientDetailScreen({super.key, required this.patient});

  @override
  State<PatientDetailScreen> createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailScreen> {
  late TextEditingController notesController;

  @override
  void initState() {
    notesController = TextEditingController(text: widget.patient.notes);

    super.initState();
  }

  callPatient() async {
    final Uri phoneUri = Uri.parse("tel:${widget.patient.phone}");

    await launchUrl(phoneUri);
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.patient;

    return Scaffold(
      appBar: AppBar(title: Text(p.name)),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(radius: 40, backgroundImage: AssetImage(p.image)),

            const SizedBox(height: 15),

            Text("Age: ${p.age}"),

            Text("Trimester: ${p.trimester}"),

            const SizedBox(height: 15),

            /// NEW MEDICAL INFO
            const Text(
              "Medical Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text("Blood Group: ${p.bloodGroup}"),

                    Text("Height: ${p.height} cm"),

                    Text("Weight: ${p.weight} kg"),

                    Text("Hemoglobin: ${p.hemoglobin} g/dL"),

                    Text("Platelets: ${p.platelets} lakh"),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Doctor Notes
            const Text(
              "Doctor Notes",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            TextField(
              controller: notesController,
              maxLines: 4,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UploadReportScreen(patient: p),
                  ),
                ).then((_) {
                  setState(() {});
                });
              },

              icon: const Icon(Icons.upload),

              label: const Text("Upload Report"),
            ),

            /// REPORTS SECTION
            const Text(
              "Reports",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            FutureBuilder<List<Report>>(
              future: ReportStorage.loadReports(),

              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();

                final reports = snapshot.data!;

                return ListView.builder(
                  itemCount: reports.length,

                  itemBuilder: (context, index) {
                    final report = reports[index];

                    return Card(
                      child: ListTile(
                        title: Text(report.title),

                        subtitle: Text(report.date),

                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ReportViewScreen(report: report),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
