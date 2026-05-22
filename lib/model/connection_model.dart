class DoctorRequest {
  String patientId;
  String patientName;
  String patientImage;

  String doctorId;
  String status;
  // pending / accepted

  DoctorRequest({
    required this.patientId,
    required this.patientName,
    required this.patientImage,
    required this.doctorId,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      "patientId": patientId,
      "patientName": patientName,
      "patientImage": patientImage,
      "doctorId": doctorId,
      "status": status,
    };
  }

  factory DoctorRequest.fromJson(Map<String, dynamic> json) {
    return DoctorRequest(
      patientId: json["patientId"],
      patientName: json["patientName"],
      patientImage: json["patientImage"],
      doctorId: json["doctorId"],
      status: json["status"],
    );
  }
}
