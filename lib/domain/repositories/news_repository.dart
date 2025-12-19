import '../entities/article_entity.dart';

abstract class NewsRepository {
  Future<List<ArticleEntity>> getTopHeadlines(String category);
  Future<List<ArticleEntity>> searchNews(String query);
}
