// import 'package:finalapp/classes/article_detail_page.dart';
// import 'package:finalapp/classes/article_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class SavedPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final articleProvider = Provider.of<ArticleProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Saved Articles'),
//       ),
//       body: articleProvider.savedArticles.isEmpty
//           ? const Center(
//         child: Text('No saved articles'),
//       )
//           : ListView.builder(
//         itemCount: articleProvider.savedArticles.length,
//         itemBuilder: (context, index) {
//           final article = articleProvider.savedArticles[index];
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


class SavedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final articleProvider = Provider.of<ArticleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Articles'),
      ),
      body: articleProvider.savedArticles.isEmpty
          ? const Center(
        child: Text('No saved articles'),
      )
          : ListView.builder(
        itemCount: articleProvider.savedArticles.length,
        itemBuilder: (context, index) {
          final article = articleProvider.savedArticles[index];
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
