import '../../domain/entities/article_entity.dart';

class ArticleModel extends ArticleEntity {
  const ArticleModel({
    required super.title,
    required super.description,
    required super.urlToImage,
    required super.publishedAt,
    required super.content,
    required super.source,
    required super.url,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      urlToImage: json['urlToImage'] ?? 'https://via.placeholder.com/300',
      publishedAt: json['publishedAt'] ?? '',
      content: json['content'] ?? '',
      source: json['source']?['name'] ?? 'Unknown',
      url: json['url'] ?? '',
    );
  }

  factory ArticleModel.fromNewsDataJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      urlToImage: json['image_url'] ?? 'https://via.placeholder.com/300',
      publishedAt: json['pubDate'] ?? '',
      content: json['content'] ?? '',
      source: json['source_id'] ?? 'NewsData.io',
      url: json['link'] ?? '',
    );
  }

  factory ArticleModel.fromRssJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No description available',
      urlToImage:
          json['thumbnail'] ??
          (json['enclosure']?['link'] ?? 'https://via.placeholder.com/300'),
      publishedAt: json['pubDate'] ?? '',
      content: json['content'] ?? '',
      source: 'BBC News',
      url: json['link'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
      'source': {'name': source},
      'url': url,
    };
  }
}
