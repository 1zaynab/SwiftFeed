/*
import 'package:flutter/material.dart';
//import 'package:retrievee/show_article.dart';
import '../classes/article.dart';

class LikedPage extends StatefulWidget {
  final Article article;

  const LikedPage({super.key, required this.article});

  @override
  _LikedPageState createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage> {
  final List<Article> _likedArticles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liked Articles'),
      ),
      body: _likedArticles.isEmpty
          ? const Center(
        child: Text('No liked articles'),
      )
          : ListView.builder(
        itemCount: _likedArticles.length,
        itemBuilder: (context, index) {
          final article = _likedArticles[index];
          return ListTile(
            title: Text(article.username),
            subtitle: Text(article.name),
            */
/*onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowArticlePage(article: article),
                ),
              );
            },*//*

          );
        },
      ),
    );
  }
}*/



import 'package:flutter/material.dart';
//import 'package:retrievee/show_article.dart';
import '../classes/article.dart';

class LikedPage extends StatefulWidget {


  @override
  _LikedPageState createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage> {
  final List<Article> _likedArticles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Articles'),
      ),
      body: _likedArticles.isEmpty
          ? const Center(
        child: Text('No saved articles'),
      )
          : ListView.builder(
        itemCount: _likedArticles.length,
        itemBuilder: (context, index) {
          final article = _likedArticles[index];
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