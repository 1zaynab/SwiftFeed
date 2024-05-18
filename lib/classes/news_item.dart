class NewsItem {
  final int id;
  final String title;
  final String imgUrl;
  final String category;
  final String author;
  final String time;
  final bool isFavorite;

  NewsItem({
    required this.id,
    required this.title,
    required this.imgUrl,
    required this.category,
    required this.author,
    this.isFavorite = false,
    this.time = '8 minutes ago',
  });

  NewsItem copyWith({
    int? id,
    String? title,
    String? imgUrl,
    String? category,
    String? author,
    String? time,
    bool? isFavorite,
  }) {
    return NewsItem(
      id: id ?? this.id,
      title: title ?? this.title,
      imgUrl: imgUrl ?? this.imgUrl,
      category: category ?? this.category,
      author: author ?? this.author,
      time: time ?? this.time,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

List<NewsItem> news = [
  NewsItem(
    id: 1,
    title: 'This is a freaking title here',
    imgUrl:
        'https://imgs.search.brave.com/RCNSDgFEqeTj55NJZlXRe5_8EcAa7QwBNyps8uRy_T0/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pbWFn/ZXMudW5zcGxhc2gu/Y29tL3Bob3RvLTE1/MjYyNDE2NzE2OTIt/ZTdkMzE5NWM5NTMx/P3E9ODAmdz0xMDAw/JmF1dG89Zm9ybWF0/JmZpdD1jcm9wJml4/bGliPXJiLTQuMC4z/Jml4aWQ9TTN3eE1q/QTNmREI4TUh4bGVI/QnNiM0psTFdabFpX/UjhNVGQ4Zkh4bGJu/d3dmSHg4Zkh3PQ.jpeg',
    category: 'Sports',
    author: 'CNN',
  ),
  NewsItem(
    id: 2,
    title: 'This is a very good title here',
    imgUrl:
        'https://imgs.search.brave.com/RCNSDgFEqeTj55NJZlXRe5_8EcAa7QwBNyps8uRy_T0/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pbWFn/ZXMudW5zcGxhc2gu/Y29tL3Bob3RvLTE1/MjYyNDE2NzE2OTIt/ZTdkMzE5NWM5NTMx/P3E9ODAmdz0xMDAw/JmF1dG89Zm9ybWF0/JmZpdD1jcm9wJml4/bGliPXJiLTQuMC4z/Jml4aWQ9TTN3eE1q/QTNmREI4TUh4bGVI/QnNiM0psTFdabFpX/UjhNVGQ4Zkh4bGJu/d3dmSHg4Zkh3PQ.jpeg',
    category: 'Social',
    author: 'BBC',
  ),
  NewsItem(
    id: 3,
    title: 'This is an amazing title here',
    imgUrl:
        'https://imgs.search.brave.com/RCNSDgFEqeTj55NJZlXRe5_8EcAa7QwBNyps8uRy_T0/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pbWFn/ZXMudW5zcGxhc2gu/Y29tL3Bob3RvLTE1/MjYyNDE2NzE2OTIt/ZTdkMzE5NWM5NTMx/P3E9ODAmdz0xMDAw/JmF1dG89Zm9ybWF0/JmZpdD1jcm9wJml4/bGliPXJiLTQuMC4z/Jml4aWQ9TTN3eE1q/QTNmREI4TUh4bGVI/QnNiM0psTFdabFpX/UjhNVGQ4Zkh4bGJu/d3dmSHg4Zkh3PQ.jpeg',
    category: 'Medical',
    author: 'National',
  ),
  NewsItem(
    id: 4,
    title: 'This is an excellent title here',
    imgUrl: 'https://imgs.search.brave.com/RCNSDgFEqeTj55NJZlXRe5_8EcAa7QwBNyps8uRy_T0/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pbWFn/ZXMudW5zcGxhc2gu/Y29tL3Bob3RvLTE1/MjYyNDE2NzE2OTIt/ZTdkMzE5NWM5NTMx/P3E9ODAmdz0xMDAw/JmF1dG89Zm9ybWF0/JmZpdD1jcm9wJml4/bGliPXJiLTQuMC4z/Jml4aWQ9TTN3eE1q/QTNmREI4TUh4bGVI/QnNiM0psTFdabFpX/UjhNVGQ4Zkh4bGJu/d3dmSHg4Zkh3PQ.jpeg',
    category: 'Political',
    author: 'CNN',
  ),
];
