import 'report_model.dart';

class Patient {
  String id;
  String name;
  String image;
  String phone;

  int age;
  String trimester;
  String notes;

  /// NEW HEALTH DATA

  String bloodGroup;

  double height;

  double weight;

  double hemoglobin;

  double platelets;

  List<Report> reports;

  Patient({
    required this.id,
    required this.name,
    required this.image,
    required this.phone,
    required this.age,
    required this.trimester,
    required this.notes,

    required this.bloodGroup,
    required this.height,
    required this.weight,
    required this.hemoglobin,
    required this.platelets,

    required this.reports,
  });
}
