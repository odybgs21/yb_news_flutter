import '../entities/article_entity.dart';
import '../repositories/news_repository.dart';

class GetTopHeadlinesUseCase {
  final NewsRepository repository;

  GetTopHeadlinesUseCase(this.repository);

  Future<List<ArticleEntity>> call(String category) {
    return repository.getTopHeadlines(category);
  }
}
