class PregnancyUser {
  String name;
  int age;
  int pregnancyWeek;
  double height;
  double weight;
  String bloodGroup;
  String diseases;
  String allergies;
  int previousPregnancies;
  String doctorName;
  String emergencyContact;

  PregnancyUser({
    required this.name,
    required this.age,
    required this.pregnancyWeek,
    required this.height,
    required this.weight,
    required this.bloodGroup,
    required this.diseases,
    required this.allergies,
    required this.previousPregnancies,
    required this.doctorName,
    required this.emergencyContact,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "age": age,
      "pregnancyWeek": pregnancyWeek,
      "height": height,
      "weight": weight,
      "bloodGroup": bloodGroup,
      "diseases": diseases,
      "allergies": allergies,
      "previousPregnancies": previousPregnancies,
      "doctorName": doctorName,
      "emergencyContact": emergencyContact,
    };
  }

  factory PregnancyUser.fromJson(Map<String, dynamic> json) {
    return PregnancyUser(
      name: json["name"],
      age: json["age"],
      pregnancyWeek: json["pregnancyWeek"],
      height: json["height"],
      weight: json["weight"],
      bloodGroup: json["bloodGroup"],
      diseases: json["diseases"],
      allergies: json["allergies"],
      previousPregnancies: json["previousPregnancies"],
      doctorName: json["doctorName"],
      emergencyContact: json["emergencyContact"],
    );
  }
}
