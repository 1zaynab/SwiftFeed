import 'package:flutter/material.dart';
//import 'package:retrievee/show_article.dart';
import '../classes/article.dart';

class SavedPage extends StatefulWidget {


  @override
  _SavedPageState createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  final List<Article> _savedArticles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Articles'),
      ),
      body: _savedArticles.isEmpty
          ? const Center(
        child: Text('No saved articles'),
      )
          : ListView.builder(
        itemCount: _savedArticles.length,
        itemBuilder: (context, index) {
          final article = _savedArticles[index];
          return ListTile(
            title: Text(article.username),
            subtitle: Text(article.name),
            /*onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowArticlePage(article: article),
                ),
              );
            },*/
          );
        },
      ),
    );
  }
}