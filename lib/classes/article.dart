class Article {
  final String name;
  final String username;
  final String timestamp;
  final bool verified;
  final String content;
  final String category;
  final String comments;
  final String retweets;
  final String likes;
  final String analytics;
  final String tags;
  final String profileImage;
  final String tweetLink;
  final String tweetImage;

  Article({
    required this.name,
    required this.username,
    required this.timestamp,
    required this.verified,
    required this.content,
    required this.category,
    required this.comments,
    required this.retweets,
    required this.likes,
    required this.analytics,
    required this.tags,
    required this.profileImage,
    required this.tweetLink,
    required this.tweetImage,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      name: json["Name"] ?? '',
      username: json["Username"] ?? '',
      timestamp: json["Timestamp"] ?? '',
      verified: json["Verified"] ?? false,
      content: json["Content"] ?? '',
      category: json["Category"] ?? '',
      comments: json["Comments"] ?? '0',
      retweets: json["Retweets"] ?? '0',
      likes: json["Likes"] ?? '0',
      analytics: json["Analytics"] ?? '0',
      tags: json["Tags"] ?? '',
      profileImage: json["Profile Image"] ?? '',
      tweetLink: json["Tweet Link"] ?? '',
      tweetImage: json["Tweet Image"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'Name': name,
    'Username': username,
    'Timestamp': timestamp,
    'Verified': verified,
    'Content': content,
    'Category': category,
    'Comments': comments,
    'Retweets': retweets,
    'Likes': likes,
    'Analytics': analytics,
    'Tags': tags,
    'Profile Image': profileImage,
    'Tweet Link': tweetLink,
    'Tweet Image': tweetImage,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Article &&
              runtimeType == other.runtimeType &&
              username == other.username &&
              name == other.name &&
              content == other.content &&
              category == other.category &&
              tweetImage == other.tweetImage;

  @override
  int get hashCode =>
      username.hashCode ^ name.hashCode ^ content.hashCode ^ category.hashCode ^ tweetImage.hashCode;
}
