// /*
// class Article {
//   final String name;
//   final String username;
//   final String timestamp;
//   final String content;
//   final String likes;
//   final String profileImage;
//   final String tweetLink;
//
//   Article({
//     required this.name,
//     required this.username,
//     required this.timestamp,
//     required this.content,
//     required this.likes,
//     required this.profileImage,
//     required this.tweetLink,
//   });
//
//   factory Article.fromJson(Map<String, dynamic> json) {
//     return Article(
//       name: json["Name"],
//       username: json["Username"],
//       timestamp: json["Timestamp"],
//       content: json["Content"],
//       likes: json["Likes"],
//       profileImage: json["Profile Image"],
//       tweetLink: json["Tweet Link"],
//     );
//   }
// }
// */
//
//
// class Article {
//   final String name;
//   final String username;
//   final String timestamp;
//   final bool  verified;
//   final String content;
//   final String comments;
//   final String retweets;
//   final String likes;
//   final String analytics;
//   final String tags;
//   final String profileImage;
//   final String tweetLink;
//   final String tweetImage;
//
//   Article({
//     required this.name,
//     required this.username,
//     required this.timestamp,
//     required this.verified,
//     required this.content,
//     required this.comments,
//     required this.retweets,
//     required this.likes,
//     required this.analytics,
//     required this.tags,
//     required this.profileImage,
//     required this.tweetLink,
//     required this.tweetImage,
//   });
//
//   factory Article.fromJson(Map<String, dynamic> json) {
//     return Article(
//       name: json["Name"] ?? '',
//       username: json["Username"] ?? '',
//       timestamp: json["Timestamp"] ?? '',
//       verified: json["Verified"] ?? false,
//       content: json["Content"] ?? '',
//       comments: json["Comments"] ?? '0',
//       retweets: json["Retweets"] ?? '0',
//       likes: json["Likes"] ?? '0',
//       analytics: json["Analytics"] ?? '0',
//       tags: json["Tags"] ?? '',
//       profileImage: json["Profile Image"] ?? '',
//       tweetLink: json["Tweet Link"] ?? '',
//       tweetImage: json["Tweet Image"] ?? '',
//     );
//
//   }
// }


class Article {
  final String name;
  final String username;
  final String timestamp;
  final bool verified;
  final String content;
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
              tweetImage == other.tweetImage;

  @override
  int get hashCode =>
      username.hashCode ^ name.hashCode ^ content.hashCode ^ tweetImage.hashCode;
}
