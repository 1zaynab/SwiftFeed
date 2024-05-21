// import 'package:flutter/material.dart';
// import 'article.dart';
//
// class ArticleProvider extends ChangeNotifier {
//   List<Article> _savedArticles = [];
//   List<Article> _likedArticles = [];
//
//   List<Article> get savedArticles => _savedArticles;
//   List<Article> get likedArticles => _likedArticles;
//
//   void toggleSaveArticle(Article article) {
//     if (_savedArticles.contains(article)) {
//       _savedArticles.remove(article);
//     } else {
//       _savedArticles.add(article);
//     }
//     notifyListeners();
//   }
//
//   void toggleLikeArticle(Article article) {
//     if (_likedArticles.contains(article)) {
//       _likedArticles.remove(article);
//     } else {
//       _likedArticles.add(article);
//     }
//     notifyListeners();
//   }
// }
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'article.dart';

class ArticleProvider extends ChangeNotifier {
  List<Article> _savedArticles = [];
  List<Article> _likedArticles = [];

  List<Article> get savedArticles => _savedArticles;
  List<Article> get likedArticles => _likedArticles;

  ArticleProvider() {
    _loadSavedArticles();
    _loadLikedArticles();
  }

  void toggleSaveArticle(Article article) {
    if (_savedArticles.contains(article)) {
      _savedArticles.remove(article);
    } else {
      _savedArticles.add(article);
    }
    _saveArticlesToPrefs('savedArticles', _savedArticles);
    notifyListeners();
  }

  void toggleLikeArticle(Article article) {
    if (_likedArticles.contains(article)) {
      _likedArticles.remove(article);
    } else {
      _likedArticles.add(article);
    }
    _saveArticlesToPrefs('likedArticles', _likedArticles);
    notifyListeners();
  }

  void _saveArticlesToPrefs(String key, List<Article> articles) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> articleList = articles.map((article) => json.encode(article.toJson())).toList();
    prefs.setStringList(key, articleList);
  }

  void _loadSavedArticles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? articleList = prefs.getStringList('savedArticles');
    if (articleList != null) {
      _savedArticles = articleList.map((article) => Article.fromJson(json.decode(article))).toList();
      notifyListeners();
    }
  }

  void _loadLikedArticles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? articleList = prefs.getStringList('likedArticles');
    if (articleList != null) {
      _likedArticles = articleList.map((article) => Article.fromJson(json.decode(article))).toList();
      notifyListeners();
    }
  }
}
