import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_aggregator/models/news_article.dart';

class NewsService {
  final String _apiKey = 'adc35a38a4bb469ab16866ef5cec6ede';
  final String _baseUrl = 'https://newsapi.org/v2/top-headlines';

  Future<List<NewsArticle>> fetchNews() async {
    final response = await http.get(Uri.parse('$_baseUrl?country=us&apiKey=$_apiKey'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['articles'];
      return jsonResponse.map((article) => NewsArticle.fromJson(article)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
