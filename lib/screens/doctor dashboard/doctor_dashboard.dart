import 'package:flutter/material.dart';
import 'package:pregmaa/data/dummy_data.dart';
import 'package:pregmaa/widgets/doctor_info_card.dart';
import 'package:pregmaa/widgets/patient_tile.dart';
import 'package:pregmaa/widgets/slot_section.dart';

import 'patient_detail_screen.dart';
import 'slot_edit_screen.dart';

class DoctorDashboard extends StatelessWidget {
  const DoctorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Doctor Dashboard")),

      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Doctor Info
            DoctorInfoCard(doctor: doctor),

            const SizedBox(height: 15),

            /// Patient List
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Patients",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: patients.length,
                    itemBuilder: (context, index) {
                      final patient = patients[index];

                      return PatientTile(
                        patient: patient,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  PatientDetailScreen(patient: patient),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),

            /// Slot Section
            SlotSection(
              slots: slots,
              onEdit: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SlotEditScreen()),
                );
              },
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
