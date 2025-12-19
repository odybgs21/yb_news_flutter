import '../../domain/entities/article_entity.dart';
import '../../domain/repositories/news_repository.dart';
import '../providers/news_provider.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsProvider provider;

  NewsRepositoryImpl({required this.provider});

  @override
  Future<List<ArticleEntity>> getTopHeadlines(String category) async {
    return await provider.getTopHeadlines(category);
  }

  @override
  Future<List<ArticleEntity>> searchNews(String query) async {
    return await provider.searchNews(query);
  }
}
