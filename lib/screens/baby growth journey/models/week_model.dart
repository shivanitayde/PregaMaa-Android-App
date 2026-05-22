class WeekModel {
  final int week;
  final String babySize;
  final String weight;
  final String length;
  final String development;
  final String model;

  WeekModel({
    required this.week,
    required this.babySize,
    required this.weight,
    required this.length,
    required this.development,
    required this.model,
  });

  factory WeekModel.fromMap(Map<String, dynamic> map) {
    return WeekModel(
      week: map['week'],
      babySize: map['baby_size'],
      weight: map['weight'],
      length: map['length'],
      development: map['development'],
      model: map['model'],
    );
  }
}
