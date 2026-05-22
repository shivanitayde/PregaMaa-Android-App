class ArticleSection {
  final String headingEn;
  final String headingHi;
  final String headingMr;

  final List<String> pointsEn;
  final List<String> pointsHi;
  final List<String> pointsMr;

  ArticleSection({
    required this.headingEn,
    required this.headingHi,
    required this.headingMr,

    required this.pointsEn,
    required this.pointsHi,
    required this.pointsMr,
  });

  String getHeading(String lang) {
    switch (lang) {
      case "hi":
        return headingHi;

      case "mr":
        return headingMr;

      default:
        return headingEn;
    }
  }

  List<String> getPoints(String lang) {
    switch (lang) {
      case "hi":
        return pointsHi;

      case "mr":
        return pointsMr;

      default:
        return pointsEn;
    }
  }
}
