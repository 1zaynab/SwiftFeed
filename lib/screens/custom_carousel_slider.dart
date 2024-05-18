

import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../classes/article.dart';
import '../classes/article_detail_page.dart';

class CustomCarouselSlider extends StatefulWidget {
  final List<Article> articles;

  const CustomCarouselSlider({Key? key, required this.articles}) : super(key: key);

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  final CarouselController _controller = CarouselController();
  int _current = 0;
  int _startIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
      setState(() {
        _startIndex = (_startIndex + 3) % widget.articles.length; // Update startIndex for the next batch
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Article> articlesWithImage = widget.articles
        .where((article) => article.tweetImage.isNotEmpty)
        .toList();

    final List<Article> displayedArticles = [];
    if (articlesWithImage.isNotEmpty) {
      final int endIndex = _startIndex + 3;
      final int finalIndex = endIndex < articlesWithImage.length ? endIndex : articlesWithImage.length;
      displayedArticles.addAll(articlesWithImage.sublist(_startIndex, finalIndex));
      _startIndex = endIndex % articlesWithImage.length; // Reset _startIndex if it exceeds the length of articlesWithImage
    }



    return Column(
      children: [
        CarouselSlider(
          items: displayedArticles.map((article) {
            return InkWell(
              onTap: () {
                Navigator.of(context, rootNavigator: true).push(
                  CupertinoPageRoute(
                    builder: (_) => ArticleDetailPage(article: article),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(
                        article.tweetImage,
                        fit: BoxFit.cover,
                        width: 1000.0,
                      ),
                      Positioned(
                        top: 10,
                        left: 20,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              article.username,
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                ' • ${article.timestamp}',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(200, 0, 0, 0),
                                    Color.fromARGB(0, 0, 0, 0)
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                              child: Text(
                                article.content,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
          carouselController: _controller,
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 2.0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(displayedArticles.length, (index) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(index),
              child: Container(
                width: _current == index ? 25.0 : 12.0,
                height: 12.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  borderRadius: _current == index ? BorderRadius.circular(8.0) : null,
                  shape: _current == index ? BoxShape.rectangle : BoxShape.circle,
                  color: _current == index ? Theme.of(context).primaryColor : Colors.grey.withOpacity(0.3),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
