
import 'package:final_project/classes/article.dart';
import 'package:final_project/tweet_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'article_detail_page.dart';

class HomePage extends StatefulWidget {
  final String title;
  final APIService apiService;

  const HomePage({super.key, required this.title, required this.apiService});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Article>> _tweetsFuture;
  List<String>? _userInterests;

  @override
  void initState() {
    super.initState();
    // Initialize with a placeholder future
    _tweetsFuture = Future.value([]);
    _loadInterestsAndTweets();
  }

  Future<void> _loadInterestsAndTweets() async {
    // Load user interests from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    _userInterests = prefs.getStringList('interests') ?? [];

    // Load tweets after loading interests
    _loadTweets();
  }

  Future<void> _loadTweets() async {
    setState(() {
      _tweetsFuture = widget.apiService.getTweets();
    });
  }

  List<Article> _filterArticles(List<Article> articles) {
    if (_userInterests == null || _userInterests!.isEmpty) {
      return articles;
    }
    return articles.where((article) => _userInterests!.contains(article.category)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient Overlay
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
          // Main Content
          RefreshIndicator(
            onRefresh: () async {
              await _loadTweets();
            },
            child: FutureBuilder<List<Article>>(
              future: _tweetsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No tweets found'),
                  );
                } else {
                  final articles = _filterArticles(snapshot.data!);
                  if (articles.isEmpty) {
                    return const Center(
                      child: Text('No articles found for selected interests'),
                    );
                  }
                  final topArticles = articles.take(3).toList(); // Change here to take 3 articles
                  final otherArticles = articles.skip(3).toList(); // Change here to skip 3 articles

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "Top Articles",
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 250, // Adjust the height as needed
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: topArticles.length,
                            itemBuilder: (context, index) {
                              final article = topArticles[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ArticleDetailPage(article: article),
                                    ),
                                  );
                                },
                                child: Card(
                                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  elevation: 3,
                                  child: SizedBox(
                                    width: 200, // Adjust the width as needed
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (article.tweetImage.isNotEmpty)
                                          ClipRRect(
                                            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                            child: Image.network(
                                              article.tweetImage,
                                              height: 120,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  article.name,
                                                  style: const TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  article.content,
                                                  maxLines: article.tweetImage.isNotEmpty ? 1 : 5,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 14.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "All Articles",
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: otherArticles.length,
                          itemBuilder: (context, index) {
                            final article = otherArticles[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ArticleDetailPage(article: article),
                                  ),
                                );
                              },
                              child: Card(
                                margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(article.profileImage),
                                            radius: 30,
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      article.name,
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        article.content,
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                        ),
                                        maxLines: article.tweetImage.isNotEmpty ? 1 : 5,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      if (article.tweetImage.isNotEmpty)
                                        Padding(
                                          padding: const EdgeInsets.only(top: 10.0),
                                          child: Image.network(article.tweetImage),
                                        ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(Icons.favorite, color: Color(0xFFFDABAB)),
                                              const SizedBox(width: 4),
                                              Text(article.likes),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.repeat, color: Colors.cyan[100]),
                                              const SizedBox(width: 4),
                                              Text(article.analytics),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
