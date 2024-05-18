import 'package:flutter/material.dart';
import 'package:translator/translator.dart' as translator_package; // Use a translation library

import '../pages/liked_page.dart';
import '../pages/saved_page.dart';
import 'article.dart';

class ArticleDetailPage extends StatefulWidget {
  final Article article;

  const ArticleDetailPage({super.key, required this.article});

  @override
  _ArticleDetailPageState createState() => _ArticleDetailPageState();
}


class _ArticleDetailPageState extends State<ArticleDetailPage> {
  final translator = translator_package.GoogleTranslator(); // Use Google Translator
  String translatedContent = '';
  String selectedLanguage = 'all'; // Default language (all - for untranslated content)
  bool _isSaved = false;
  bool _isLiked = false;

  void navigateToSavedPage(Article article) {
    // Implement navigation to your Saved Page with the article data
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SavedPage()),
    );
  }

  void navigateToLikedPage(Article article) {
    // Implement navigation to your Liked Page with the article data
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LikedPage()),
    );
  }
  Future<void> translateArticle(String language) async {
    try {
      if (language != 'all') { // No translation needed for "all" language
        final translation = await translator.translate(widget.article.content, to: language);
        translatedContent = translation.text;
      }
      setState(() {});
    } catch (error) {
      // Handle translation error (e.g., display a message)
      print('Translation error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.article.name),
        actions: [
          DropdownButton<String>(
            value: selectedLanguage,
            items: const [
              DropdownMenuItem(value: 'all', child: Text('Default')), // Use "Default" instead of "English"
              DropdownMenuItem(value: 'en', child: Text('English')),
              DropdownMenuItem(value: 'fr', child: Text('French')),
              DropdownMenuItem(value: 'ar', child: Text('Arabic')),
            ],
            onChanged: (language) {
              translateArticle(language!); // Ensure non-null language
              selectedLanguage = language;
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.article.name,
                style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20.0),
              Text(
                // Display untranslated content or translated content based on language
                selectedLanguage == 'all' ? widget.article.content : translatedContent,
                style: const TextStyle(fontSize: 14.0),
              ),
              const SizedBox(height: 16.0),
              widget.article.tweetImage.isNotEmpty // Check for empty image URL
                  ? Hero( // Add Hero for image transition (optional)
                tag: widget.article.tweetImage,
                child: Image.network(
                  widget.article.tweetImage,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              )
                  : const SizedBox(height: 200.0), // Placeholder space for missing image
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isSaved = !_isSaved;
                        // Add navigation logic here
                        navigateToSavedPage(widget.article); // Example function call
                      });
                    },
                    icon: Icon(
                      _isSaved ? Icons.bookmark_added : Icons.bookmark_add_outlined,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isLiked = !_isLiked;
                        navigateToLikedPage(widget.article); // Example function call
                      });
                    },
                    icon: Icon(
                      _isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                    ),
                  ),

                  const SizedBox(width: 8.0),
                  IconButton(
                    onPressed: () {
                      // Share the article
                    },
                    icon: const Icon(Icons.share),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


