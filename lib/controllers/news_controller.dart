import 'package:get/get.dart';
import 'package:news_aggregator/models/news_article.dart';
import 'package:news_aggregator/services/news_provider.dart';
import "package:news_aggregator/functions/tf_idf_search.dart";

class NewsController extends GetxController {
  var allArticles = <NewsArticle>[].obs;
  var filteredArticles = <NewsArticle>[].obs;

  late TFIDFSearch tfidfSearch;

  void fetchNews() async {
    try {
      var fetched = await NewsService().fetchNews();
      allArticles.assignAll(fetched);
      filteredArticles.assignAll(fetched);
      tfidfSearch = TFIDFSearch(fetched);
    } catch (e) {
      print("Error: $e");
    }
  }

  void searchNews(String query) {
    if (query.isEmpty) {
      for (var article in allArticles) {
      article.score = 0;
    }
      filteredArticles.assignAll(allArticles);
    } else {
      final results = tfidfSearch.search(query);
      filteredArticles.assignAll(results);
    }
  }
}
