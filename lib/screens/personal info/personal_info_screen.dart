import 'package:flutter/material.dart';
import 'package:pregmaa/model/patient_model.dart';
import 'package:pregmaa/model/pregnancy_user.dart';
import 'package:pregmaa/screens/home/home.dart';
import 'package:pregmaa/services/user_storage.dart';

class PersonalInfoScreen extends StatefulWidget {
  @override
  _PersonalInfoScreenState createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  final ageController = TextEditingController();

  final weekController = TextEditingController();

  final heightController = TextEditingController();

  final weightController = TextEditingController();

  final bloodController = TextEditingController();

  final diseaseController = TextEditingController();

  final allergyController = TextEditingController();

  final pregnancyController = TextEditingController();

  final doctorController = TextEditingController();

  final emergencyController = TextEditingController();
  late final Patient patient;
  @override
  void initState() {
    super.initState();
    loadUserData(); // 🔥 load saved data
  }

  /// 🔹 Load Existing Data (Edit Mode)
  Future<void> loadUserData() async {
    PregnancyUser? user = await UserStorage.getUser();

    if (user != null) {
      nameController.text = user.name;

      ageController.text = user.age.toString();

      weekController.text = user.pregnancyWeek.toString();

      heightController.text = user.height.toString();

      weightController.text = user.weight.toString();

      bloodController.text = user.bloodGroup;

      diseaseController.text = user.diseases;

      allergyController.text = user.allergies;

      pregnancyController.text = user.previousPregnancies.toString();

      doctorController.text = user.doctorName;

      emergencyController.text = user.emergencyContact;
    }
  }

  /// 🔹 Save Data
  Future<void> saveUserData() async {
    if (_formKey.currentState!.validate()) {
      PregnancyUser user = PregnancyUser(
        name: nameController.text,

        age: int.parse(ageController.text),

        pregnancyWeek: int.parse(weekController.text),

        height: double.parse(heightController.text),

        weight: double.parse(weightController.text),

        bloodGroup: bloodController.text,

        diseases: diseaseController.text,

        allergies: allergyController.text,

        previousPregnancies: int.parse(pregnancyController.text),

        doctorName: doctorController.text,

        emergencyContact: emergencyController.text,
      );

      await UserStorage.saveUser(user);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Information Saved")));

      /// Navigate to Home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home(patient: patient)),
      );
    }
  }

  /// 🔹 Field Builder
  Widget buildField(
    String label,
    TextEditingController controller, {
    TextInputType type = TextInputType.text,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),

      child: TextFormField(
        controller: controller,
        keyboardType: type,

        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Required";
          }

          return null;
        },

        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Personal Pregnancy Info")),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),

        child: Form(
          key: _formKey,

          child: Column(
            children: [
              buildField("Name", nameController),

              buildField("Age", ageController, type: TextInputType.number),

              buildField(
                "Pregnancy Week",
                weekController,
                type: TextInputType.number,
              ),

              buildField(
                "Height (cm)",
                heightController,
                type: TextInputType.number,
              ),

              buildField(
                "Weight (kg)",
                weightController,
                type: TextInputType.number,
              ),

              buildField("Blood Group", bloodController),

              buildField(
                "Emergency Contact",
                emergencyController,
                type: TextInputType.phone,
              ),

              SizedBox(height: 20),

              /// 🔥 Correct Save Button
              ElevatedButton(
                onPressed: saveUserData,

                child: Text("Save Information"),
              ),

              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    weekController.dispose();
    heightController.dispose();
    weightController.dispose();
    bloodController.dispose();
    diseaseController.dispose();
    allergyController.dispose();
    pregnancyController.dispose();
    doctorController.dispose();
    emergencyController.dispose();

    super.dispose();
  }
}
