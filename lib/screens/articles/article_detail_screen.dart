import 'package:flutter/material.dart';
import 'package:pregmaa/model/article_model.dart';
import 'package:pregmaa/services/tts_service.dart';
import 'package:pregmaa/widgets/article_section_widget.dart';

class ArticleDetailScreen extends StatefulWidget {
  final Article article;
  final String lang;

  const ArticleDetailScreen({
    super.key,
    required this.article,
    required this.lang,
  });

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  bool isSpeaking = false;

  void toggleSpeech() async {
    if (isSpeaking) {
      await TTSService.stop();

      setState(() {
        isSpeaking = false;
      });
    } else {
      String textToRead =
          widget.article.getTitle(widget.lang) +
          ". " +
          widget.article.getIntro(widget.lang);

      for (var section in widget.article.sections) {
        textToRead += ". " + section.getHeading(widget.lang);

        for (var p in section.getPoints(widget.lang)) {
          textToRead += ". " + p;
        }
      }

      await TTSService.speak(textToRead, widget.lang);

      setState(() {
        isSpeaking = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final article = widget.article;

    return Scaffold(
      appBar: AppBar(title: Text(article.getTitle(widget.lang))),

      floatingActionButton: FloatingActionButton(
        onPressed: toggleSpeech,

        child: Icon(isSpeaking ? Icons.stop : Icons.volume_up),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Text(
                article.getTitle(widget.lang),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              /// Introduction
              Text(
                article.getIntro(widget.lang),
                style: const TextStyle(fontSize: 16, height: 1.6),
              ),

              const SizedBox(height: 20),

              /// Sections
              ...article.sections.map(
                (section) =>
                    ArticleSectionWidget(section: section, lang: widget.lang),
              ),

              /// Source
              const SizedBox(height: 20),

              Text(
                "Source: ${article.source}",
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
