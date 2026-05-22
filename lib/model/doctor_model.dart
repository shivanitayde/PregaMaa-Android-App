class Doctor {
  String name;
  String designation;
  String hospital;
  String contact;

  /// ADD THIS FIELD
  String image;

  Doctor({
    required this.name,
    required this.designation,
    required this.hospital,
    required this.contact,
    required this.image,
  });
  Map<String, dynamic> toJson() => {
    "name": name,
    "designation": designation,
    "hospital": hospital,
    "contact": contact,
    "image": image,
  };

  /// ADD THIS
  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      name: json["name"],
      designation: json["designation"],
      hospital: json["hospital"],
      contact: json["contact"],
      image: json["image"],
    );
  }
}
