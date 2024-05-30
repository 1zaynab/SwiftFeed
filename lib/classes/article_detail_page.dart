import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart' as translator_package;
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

import '../classes/article.dart';
import '../classes/article_provider.dart';

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

  void _showImageZoom(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
          ),
          body: PhotoViewGallery(
            pageOptions: [
              PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(imageUrl),
                heroAttributes: PhotoViewHeroAttributes(tag: imageUrl),
              ),
            ],
            backgroundDecoration: BoxDecoration(color: Colors.black),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final articleProvider = Provider.of<ArticleProvider>(context);
    final theme = Theme.of(context);

    bool hasTweetImage = widget.article.tweetImage.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor.withOpacity(0.8),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Details',
          style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold),
        ),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedLanguage,
              dropdownColor: theme.scaffoldBackgroundColor,
              icon: Icon(Icons.language, color: theme.iconTheme.color),
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
          ),
        ],
      ),
      body: Stack(
        children: [
          if (hasTweetImage)
            GestureDetector(
              onTap: () => _showImageZoom(context, widget.article.tweetImage),
              child: Hero(
                tag: widget.article.tweetImage,
                child: Image.network(
                  widget.article.tweetImage,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          DraggableScrollableSheet(
            initialChildSize: hasTweetImage ? 0.67 : 1.0,
            minChildSize: hasTweetImage ? 0.67 : 1.0,
            maxChildSize: 1.0,
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: hasTweetImage
                      ? const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )
                      : null,
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!hasTweetImage) const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.article.category,
                            style: TextStyle(
                              fontSize: 24.0,
                              color: theme.textTheme.bodyLarge?.color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.article.timestamp,
                            style: TextStyle(
                              color: theme.textTheme.bodySmall?.color,
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        selectedLanguage == 'all' ? widget.article.content : translatedContent,
                        style: TextStyle(
                          fontSize: 25.0,
                          color: theme.textTheme.bodyLarge?.color,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          if (hasTweetImage)
                            CircleAvatar(
                              backgroundImage: NetworkImage(widget.article.tweetImage),
                            ),
                          if (hasTweetImage) const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.article.name,
                                style: TextStyle(
                                  color: theme.textTheme.bodyLarge?.color,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                widget.article.username,
                                style: TextStyle(
                                  color: theme.textTheme.bodySmall?.color,
                                  fontSize: 15.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
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
                                  color: theme.primaryColor,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isLiked = !_isLiked;
                                    articleProvider.toggleLikeArticle(widget.article);
                                  });
                                },
                                icon: Icon(
                                  _isLiked
                                      ? Icons.favorite_rounded
                                      : Icons.favorite_border_rounded,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
