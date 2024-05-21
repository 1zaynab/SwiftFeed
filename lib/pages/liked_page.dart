// import 'package:finalapp/classes/article_detail_page.dart';
// import 'package:finalapp/classes/article_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
//
// class LikedPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final articleProvider = Provider.of<ArticleProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Liked Articles'),
//       ),
//       body: articleProvider.likedArticles.isEmpty
//           ? const Center(
//         child: Text('No liked articles'),
//       )
//           : ListView.builder(
//         itemCount: articleProvider.likedArticles.length,
//         itemBuilder: (context, index) {
//           final article = articleProvider.likedArticles[index];
//           return ListTile(
//             title: Text(article.username),
//             subtitle: Text(article.name),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ArticleDetailPage(article: article),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:finalapp/classes/article_detail_page.dart';
import 'package:finalapp/classes/article_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LikedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final articleProvider = Provider.of<ArticleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liked Articles'),
      ),
      body: articleProvider.likedArticles.isEmpty
          ? const Center(
        child: Text('No liked articles'),
      )
          : ListView.builder(
        itemCount: articleProvider.likedArticles.length,
        itemBuilder: (context, index) {
          final article = articleProvider.likedArticles[index];
          return ListTile(
            title: Text(article.username),
            subtitle: Text(article.name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticleDetailPage(article: article),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
