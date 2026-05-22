class Report {
  String id;
  String title;
  String fileUrl;
  String fileType;
  String date;
  String doctorSuggestion;

  Report({
    required this.id,
    required this.title,
    required this.fileUrl,
    required this.fileType,
    required this.date,
    required this.doctorSuggestion,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "fileUrl": fileUrl,
      "fileType": fileType,
      "date": date,
      "doctorSuggestion": doctorSuggestion,
    };
  }

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json["id"],
      title: json["title"],
      fileUrl: json["fileUrl"],
      fileType: json["fileType"],
      date: json["date"],
      doctorSuggestion: json["doctorSuggestion"] ?? "",
    );
  }
}
