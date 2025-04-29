class NewsArticle {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  double score;

  NewsArticle(
      {required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      this.score=0.0});

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
    );
  }
}


