import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_aggregator/controllers/news_controller.dart';
import 'package:news_aggregator/models/news_article.dart';

class HomePage extends StatelessWidget {
  final NewsController _newsController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    _newsController.fetchNews();

    return Scaffold(
      appBar: AppBar(
        title: const Text('News Aggregator'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _newsController.searchNews,
              decoration: InputDecoration(
                hintText: 'Search news...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (_newsController.filteredArticles.isEmpty) {
          return const Center(child: Text('No articles found.'));
        } else {
          return ListView.builder(
            itemCount: _newsController.filteredArticles.length,
            itemBuilder: (context, index) {
              NewsArticle article = _newsController.filteredArticles[index];
              return ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    article.score != 0
                        ? Text(article.score.toStringAsFixed(4))
                        : const SizedBox(),
                    Flexible(
                      child: article.urlToImage.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.network(
                                article.urlToImage,
                                width: 50,
                                height: 40, 
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Icon(Icons.image, size: 40),
                    ),
                  ],
                ),
                title: Text(article.title),
                subtitle: Text(article.description),
                onTap: () {
                  _openArticle(article.url);
                },
              );
            },
          );
        }
      }),
    );
  }

  void _openArticle(String url) {
    //future scope
  }
}
