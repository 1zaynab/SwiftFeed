// import 'package:finalapp/classes/article.dart';
// import 'package:finalapp/classes/article_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:translator/translator.dart' as translator_package;
//
//
// class ArticleDetailPage extends StatefulWidget {
//   final Article article;
//
//   const ArticleDetailPage({super.key, required this.article});
//
//   @override
//   _ArticleDetailPageState createState() => _ArticleDetailPageState();
// }
//
// class _ArticleDetailPageState extends State<ArticleDetailPage> {
//   final translator = translator_package.GoogleTranslator();
//   String translatedContent = '';
//   String selectedLanguage = 'all';
//   bool _isSaved = false;
//   bool _isLiked = false;
//
//   @override
//   void initState() {
//     super.initState();
//     final articleProvider = Provider.of<ArticleProvider>(context, listen: false);
//     _isSaved = articleProvider.savedArticles.contains(widget.article);
//     _isLiked = articleProvider.likedArticles.contains(widget.article);
//   }
//
//   Future<void> translateArticle(String language) async {
//     try {
//       if (language != 'all') {
//         final translation = await translator.translate(widget.article.content, to: language);
//         translatedContent = translation.text;
//       }
//       setState(() {});
//     } catch (error) {
//       print('Translation error: $error');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final articleProvider = Provider.of<ArticleProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.article.name),
//         actions: [
//           DropdownButton<String>(
//             value: selectedLanguage,
//             items: const [
//               DropdownMenuItem(value: 'all', child: Text('Default')),
//               DropdownMenuItem(value: 'en', child: Text('English')),
//               DropdownMenuItem(value: 'fr', child: Text('French')),
//               DropdownMenuItem(value: 'ar', child: Text('Arabic')),
//             ],
//             onChanged: (language) {
//               translateArticle(language!);
//               setState(() {
//                 selectedLanguage = language;
//               });
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 widget.article.name,
//                 style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 20.0),
//               Text(
//                 selectedLanguage == 'all' ? widget.article.content : translatedContent,
//                 style: const TextStyle(fontSize: 14.0),
//               ),
//               const SizedBox(height: 16.0),
//               widget.article.tweetImage.isNotEmpty
//                   ? Hero(
//                 tag: widget.article.tweetImage,
//                 child: Image.network(
//                   widget.article.tweetImage,
//                   width: double.infinity,
//                   height: 200,
//                   fit: BoxFit.cover,
//                 ),
//               )
//                   : const SizedBox(height: 200.0),
//               const SizedBox(height: 16.0),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       setState(() {
//                         _isSaved = !_isSaved;
//                         articleProvider.toggleSaveArticle(widget.article);
//                       });
//                     },
//                     icon: Icon(
//                       _isSaved ? Icons.bookmark_added : Icons.bookmark_add_outlined,
//                     ),
//                   ),
//                   const SizedBox(width: 8.0),
//                   IconButton(
//                     onPressed: () {
//                       setState(() {
//                         _isLiked = !_isLiked;
//                         articleProvider.toggleLikeArticle(widget.article);
//                       });
//                     },
//                     icon: Icon(
//                       _isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
//                     ),
//                   ),
//                   const SizedBox(width: 8.0),
//                   IconButton(
//                     onPressed: () {
//                       // Share the article
//                     },
//                     icon: const Icon(Icons.share),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart' as translator_package;
import 'article.dart';
import 'article_provider.dart';

class ArticleDetailPage extends StatefulWidget {
  final Article article;

  const ArticleDetailPage({super.key, required this.article});

  @override
  _ArticleDetailPageState createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  final translator = translator_package.GoogleTranslator();
  String translatedContent = '';
  String selectedLanguage = 'all';
  bool _isSaved = false;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    final articleProvider = Provider.of<ArticleProvider>(context, listen: false);
    _isSaved = articleProvider.savedArticles.contains(widget.article);
    _isLiked = articleProvider.likedArticles.contains(widget.article);
  }

  Future<void> translateArticle(String language) async {
    try {
      if (language != 'all') {
        final translation = await translator.translate(widget.article.content, to: language);
        translatedContent = translation.text;
      }
      setState(() {});
    } catch (error) {
      print('Translation error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final articleProvider = Provider.of<ArticleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.article.name),
        actions: [
          DropdownButton<String>(
            value: selectedLanguage,
            items: const [
              DropdownMenuItem(value: 'all', child: Text('Default')),
              DropdownMenuItem(value: 'en', child: Text('English')),
              DropdownMenuItem(value: 'fr', child: Text('French')),
              DropdownMenuItem(value: 'ar', child: Text('Arabic')),
            ],
            onChanged: (language) {
              translateArticle(language!);
              setState(() {
                selectedLanguage = language;
              });
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
                selectedLanguage == 'all' ? widget.article.content : translatedContent,
                style: const TextStyle(fontSize: 14.0),
              ),
              const SizedBox(height: 16.0),
              widget.article.tweetImage.isNotEmpty
                  ? Hero(
                tag: widget.article.tweetImage,
                child: Image.network(
                  widget.article.tweetImage,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              )
                  : const SizedBox(height: 200.0),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isSaved = !_isSaved;
                        articleProvider.toggleSaveArticle(widget.article);
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
                        articleProvider.toggleLikeArticle(widget.article);
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
