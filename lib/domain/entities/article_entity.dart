class ArticleEntity {
  final String title;
  final String description;
  final String urlToImage;
  final String publishedAt;
  final String content;
  final String source;
  final String url;

  const ArticleEntity({
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    required this.source,
    required this.url,
  });
}
