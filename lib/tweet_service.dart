
import 'classes/article.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class APIService {
  final String baseUrl;

  APIService({required this.baseUrl});

  Future<List<Article>> getTweets() async {
    final response = await http.get(Uri.parse('$baseUrl/tweets'));
    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tweets');
    }
  }
}