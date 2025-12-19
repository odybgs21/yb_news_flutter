import 'package:get/get.dart';
import '../../data/providers/news_provider.dart';
import '../../data/repositories/news_repository_impl.dart';
import '../../domain/repositories/news_repository.dart';
import '../../domain/usecases/get_top_headlines_usecase.dart';
import '../../domain/usecases/search_news_usecase.dart';
import '../../presentation/controllers/news_controller.dart';
import '../../presentation/controllers/home_controller.dart';
import '../../presentation/controllers/bookmark_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // LazyPut dependencies if they aren't already registered
    Get.lazyPut<NewsProvider>(() => NewsProvider());
    Get.lazyPut<NewsRepository>(
      () => NewsRepositoryImpl(provider: Get.find<NewsProvider>()),
    );
    Get.lazyPut(() => GetTopHeadlinesUseCase(Get.find()));
    Get.lazyPut(() => SearchNewsUseCase(Get.find()));

    // Inject NewsController for Home usage
    Get.lazyPut(
      () => NewsController(
        getTopHeadlinesUseCase: Get.find(),
        searchNewsUseCase: Get.find(),
      ),
    );
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => BookmarkController(), fenix: true);
  }
}
