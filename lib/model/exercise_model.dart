class Exercise {
  String name;
  String level; // beginner / intermediate / advanced
  String trimester; // 1,2,3
  String type; // physical / meditation
  String image;
  String videoUrl;

  int duration; // minutes
  bool doctorVerified;

  Exercise({
    required this.name,
    required this.level,
    required this.trimester,
    required this.type,
    required this.image,
    required this.videoUrl,
    required this.duration,
    required this.doctorVerified,
  });
}
