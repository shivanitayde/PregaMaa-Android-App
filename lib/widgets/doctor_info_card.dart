import 'package:flutter/material.dart';
import '../model/doctor_model.dart';

class DoctorInfoCard extends StatefulWidget {
  final Doctor doctor;

  const DoctorInfoCard({super.key, required this.doctor});

  @override
  State<DoctorInfoCard> createState() => _DoctorInfoCardState();
}

class _DoctorInfoCardState extends State<DoctorInfoCard> {
  bool isEditing = false;

  late TextEditingController nameController;
  late TextEditingController designationController;
  late TextEditingController hospitalController;
  late TextEditingController contactController;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.doctor.name);

    designationController = TextEditingController(
      text: widget.doctor.designation,
    );

    hospitalController = TextEditingController(text: widget.doctor.hospital);

    contactController = TextEditingController(text: widget.doctor.contact);

    super.initState();
  }

  void saveDoctorInfo() {
    setState(() {
      widget.doctor.name = nameController.text;

      widget.doctor.designation = designationController.text;

      widget.doctor.hospital = hospitalController.text;

      widget.doctor.contact = contactController.text;

      isEditing = false;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Doctor Info Updated")));

    /// Later save to Firebase
  }

  @override
  Widget build(BuildContext context) {
    final doctor = widget.doctor;

    return Card(
      margin: const EdgeInsets.all(12),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

      elevation: 4,

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            /// Profile Image
            CircleAvatar(radius: 40, backgroundImage: AssetImage(doctor.image)),

            const SizedBox(height: 15),

            /// Name
            TextField(
              controller: nameController,
              enabled: isEditing,
              decoration: const InputDecoration(labelText: "Doctor Name"),
            ),

            const SizedBox(height: 10),

            /// Designation
            TextField(
              controller: designationController,
              enabled: isEditing,
              decoration: const InputDecoration(labelText: "Designation"),
            ),

            const SizedBox(height: 10),

            /// Hospital
            TextField(
              controller: hospitalController,
              enabled: isEditing,
              decoration: const InputDecoration(labelText: "Hospital Name"),
            ),

            const SizedBox(height: 10),

            /// Contact
            TextField(
              controller: contactController,
              enabled: isEditing,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: "Contact Number"),
            ),

            const SizedBox(height: 15),

            /// Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!isEditing)
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        isEditing = true;
                      });
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text("Edit"),
                  ),

                if (isEditing)
                  ElevatedButton.icon(
                    onPressed: saveDoctorInfo,
                    icon: const Icon(Icons.save),
                    label: const Text("Save"),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
