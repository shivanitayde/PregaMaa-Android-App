import 'package:flutter/material.dart';
import 'package:pregmaa/data/article_data.dart';
import 'package:pregmaa/screens/articles/article_detail_screen.dart';
import 'package:pregmaa/widgets/language_selector.dart';

class ArticleListScreen extends StatefulWidget {
  const ArticleListScreen({super.key});

  @override
  State<ArticleListScreen> createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends State<ArticleListScreen> {
  String selectedLang = "en";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pregnancy Articles"),

        actions: [
          LanguageSelector(
            selectedLang: selectedLang,
            onChanged: (lang) {
              setState(() {
                selectedLang = lang;
              });
            },
          ),
        ],
      ),

      body: ListView.builder(
        itemCount: pregnancyArticles.length,

        itemBuilder: (context, index) {
          final article = pregnancyArticles[index];

          return Card(
            child: ListTile(
              title: Text(article.getTitle(selectedLang)),

              trailing: const Icon(Icons.arrow_forward),

              onTap: () {
                Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (_) => ArticleDetailScreen(
                      article: article,
                      lang: selectedLang,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
