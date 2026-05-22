import 'article_section_model.dart';

class Article {
  final String id;

  final String titleEn;
  final String titleHi;
  final String titleMr;

  final String introEn;
  final String introHi;
  final String introMr;

  final List<ArticleSection> sections;

  final String source;

  Article({
    required this.id,

    required this.titleEn,
    required this.titleHi,
    required this.titleMr,

    required this.introEn,
    required this.introHi,
    required this.introMr,

    required this.sections,

    required this.source,
  });

  String getTitle(String lang) {
    switch (lang) {
      case "hi":
        return titleHi;

      case "mr":
        return titleMr;

      default:
        return titleEn;
    }
  }

  String getIntro(String lang) {
    switch (lang) {
      case "hi":
        return introHi;

      case "mr":
        return introMr;

      default:
        return introEn;
    }
  }
}
