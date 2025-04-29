import 'dart:math';
import 'package:news_aggregator/models/news_article.dart';

class TFIDFSearch {
  List<NewsArticle> articles;
  List<List<String>> tokenizedArticles = [];
  Map<String, double> idf = {};

  TFIDFSearch(this.articles) {
    _tokenizeArticles();
    _computeIDF();
  }

  void _tokenizeArticles() {
    tokenizedArticles = articles.map((a) {
      final text = '${a.title} ${a.description}'.toLowerCase();
      return text.split(RegExp(r'\W+')).where((w) => w.isNotEmpty).toList();
    }).toList();
  }

  void _computeIDF() {
    final docCount = tokenizedArticles.length;
    final wordDocCount = <String, int>{};

    for (var doc in tokenizedArticles) {
      doc.toSet().forEach((word) {
        wordDocCount[word] = (wordDocCount[word] ?? 0) + 1;
      });
    }

    for (var word in wordDocCount.keys) {
      idf[word] = log(docCount / (1 + wordDocCount[word]!));
    }
  }

  double _cosineSimilarity(Map<String, double> v1, Map<String, double> v2) {
    final allKeys = {...v1.keys, ...v2.keys};
    double dot = 0, norm1 = 0, norm2 = 0;

    for (var key in allKeys) {
      final val1 = v1[key] ?? 0;
      final val2 = v2[key] ?? 0;
      dot += val1 * val2;
      norm1 += val1 * val1;
      norm2 += val2 * val2;
    }

    return norm1 > 0 && norm2 > 0 ? dot / (sqrt(norm1) * sqrt(norm2)) : 0;
  }

  Map<String, double> _computeTF(List<String> words) {
    final tf = <String, double>{};
    for (var word in words) {
      tf[word] = (tf[word] ?? 0) + 1;
    }
    final total = words.length.toDouble();
    tf.updateAll((key, val) => val / total);
    return tf;
  }

  Map<String, double> _computeTFIDF(Map<String, double> tf) {
    final tfidf = <String, double>{};
    tf.forEach((word, freq) {
      tfidf[word] = freq * (idf[word] ?? 0);
    });
    return tfidf;
  }

  List<NewsArticle> search(String query) {
    //tf-idf for query words
    final queryWords = query.toLowerCase().split(RegExp(r'\W+'));
    final queryTF = _computeTF(queryWords);
    final queryVec = _computeTFIDF(queryTF);

    final similarities = <int, double>{};
    //tf-idf scores for news articles
    for (int i = 0; i < tokenizedArticles.length; i++) {
      final docTF = _computeTF(tokenizedArticles[i]);
      final docVec = _computeTFIDF(docTF);
      similarities[i] = _cosineSimilarity(queryVec, docVec);
    }

    final sortedIndices = similarities.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final results =
        sortedIndices.where((entry) => entry.value > 0).map((entry) {
      final article = articles[entry.key];
      article.score = entry.value;
      return article;
    }).toList();

    return results;
  }
}
