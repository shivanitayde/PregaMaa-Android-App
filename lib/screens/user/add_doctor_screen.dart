import 'package:flutter/material.dart';
import '../../model/doctor_model.dart';
import '../../services/doctor_storage.dart';

class AddDoctorScreen extends StatefulWidget {
  final Doctor? doctor;

  const AddDoctorScreen({super.key, this.doctor});
  @override
  State<AddDoctorScreen> createState() => _AddDoctorScreenState();
}

class _AddDoctorScreenState extends State<AddDoctorScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController designationController = TextEditingController();

  TextEditingController hospitalController = TextEditingController();

  TextEditingController contactController = TextEditingController();

  String imagePath = "";
  @override
  void initState() {
    super.initState();

    if (widget.doctor != null) {
      nameController.text = widget.doctor!.name;

      designationController.text = widget.doctor!.designation;

      hospitalController.text = widget.doctor!.hospital;

      contactController.text = widget.doctor!.contact;

      imagePath = widget.doctor!.image;
    }
  }

  /// SAVE DOCTOR
  Future<void> saveDoctor() async {
    Doctor doctor = Doctor(
      name: nameController.text,
      designation: designationController.text,
      hospital: hospitalController.text,
      contact: contactController.text,

      /// default image
      image: "assets/images/profile.png",
    );

    await DoctorStorage.saveDoctor(doctor);

    Navigator.pop(context);
  }

  Widget field(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),

      child: TextField(
        controller: controller,

        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Doctor")),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            field("Doctor Name", nameController),

            field("Designation", designationController),

            field("Hospital", hospitalController),

            field("Contact Number", contactController),

            const SizedBox(height: 20),

            ElevatedButton(
              child: Text("Save Doctor"),

              onPressed: () async {
                if (nameController.text.isEmpty ||
                    contactController.text.isEmpty) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Fill all fields")));
                  return;
                }

                /// Save doctor locally
                Doctor doctor = Doctor(
                  name: nameController.text,
                  designation: designationController.text,
                  hospital: hospitalController.text,
                  contact: contactController.text,
                  image: imagePath,
                );

                await DoctorStorage.saveDoctor(doctor);

                /// TEMP IDs (we will make dynamic later)
                String patientId = "patient_001";
                String doctorId = "doctor_001";

                /// Send request to Firebase

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Doctor request sent")));

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
