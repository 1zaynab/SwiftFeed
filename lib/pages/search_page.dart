
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../classes/article.dart';
import 'article_detail_page.dart';


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Article> _articleList = [];
  bool _isLoading = false;
  List<String> _userCategories = [];

  @override
  void initState() {
    super.initState();
    _fetchUserCategories();
  }

  Future<void> _fetchUserCategories() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userCategories = prefs.getStringList('interests') ?? [];
    });
  }

  Future<void> _fetchNews(String query) async {
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    String apiUrl = 'http://10.0.2.2:8000/hashtag_tweets?hashtag=${Uri.encodeComponent(query)}&max_tweets=2';

    try {
      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(utf8.decode(response.bodyBytes));

        List<Map<String, dynamic>> tweetsData = [];
        int tweetCount = responseData["Name"]?.length ?? 0;
        for (int i = 0; i < tweetCount; i++) {
          Map<String, dynamic> tweetData = {
            "Name": responseData["Name"][i],
            "Username": responseData["Username"][i],
            "Timestamp": responseData["Timestamp"][i],
            "Verified": responseData["Verified"][i],
            "Content": responseData["Content"][i],
            "Comments": responseData["Comments"][i],
            "Retweets": responseData["Retweets"][i],
            "Likes": responseData["Likes"][i],
            "Analytics": responseData["Analytics"][i],
            "Profile Image": responseData["Profile Image"][i],
            "Tweet Link": responseData["Tweet Link"][i],
            "Tweet Image": responseData["Tweet Image"][i],
          };
          tweetsData.add(tweetData);
        }

        List<Article> articleList = tweetsData.map((tweet) => Article.fromJson(tweet)).toList();

        setState(() {
          _articleList = articleList;
          _isLoading = false;
        });

      } else {
        print('Error: ${response.statusCode}');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildArticleList() {
    return ListView.builder(
      itemCount: _articleList.length,
      itemBuilder: (BuildContext context, int index) {
        Article article = _articleList[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(article.profileImage),
                  ),
                  title: Text(
                    article.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('@${article.username}'),
                  trailing: const Icon(Icons.more_vert),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArticleDetailPage(article: article),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4.0),
                      Text(
                        article.content,
                        style: const TextStyle(fontSize: 16.0),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        article.timestamp,
                        style: const TextStyle(fontSize: 12.0, color: Colors.grey),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.favorite_rounded, size: 16.0, color: Colors.grey),
                              const SizedBox(width: 4.0),
                              Text(article.likes, style: const TextStyle(color: Colors.grey)),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.repeat, size: 16.0, color: Colors.grey),
                              const SizedBox(width: 4.0),
                              Text(article.retweets, style: const TextStyle(color: Colors.grey)),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.analytics_rounded, size: 16.0, color: Colors.grey),
                              const SizedBox(width: 4.0),
                              Text(article.analytics, style: const TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Color(0xFFFDABAB),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(15.0),
                    ),
                    onSubmitted: (query) => _fetchNews(query),
                  ),
                ),
              ),
              Expanded(
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : _buildArticleList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
