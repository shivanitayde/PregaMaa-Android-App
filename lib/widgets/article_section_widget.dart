import 'package:flutter/material.dart';
import 'package:pregmaa/model/article_section_model.dart';

class ArticleSectionWidget extends StatelessWidget {
  final ArticleSection section;
  final String lang;

  const ArticleSectionWidget({
    super.key,
    required this.section,
    required this.lang,
  });

  @override
  Widget build(BuildContext context) {
    final points = section.getPoints(lang);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Heading
        Text(
          section.getHeading(lang),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 8),

        /// Bullet Points
        ...points.map(
          (point) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("• ", style: TextStyle(fontSize: 16)),

                Expanded(
                  child: Text(
                    point,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),
      ],
    );
  }
}
