import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/article_entity.dart';
import '../../domain/usecases/get_top_headlines_usecase.dart';
import '../../domain/usecases/search_news_usecase.dart';
import 'network_controller.dart';

class NewsController extends GetxController {
  final GetTopHeadlinesUseCase getTopHeadlinesUseCase;
  final SearchNewsUseCase searchNewsUseCase;

  NewsController({
    required this.getTopHeadlinesUseCase,
    required this.searchNewsUseCase,
  });

  var articles = <ArticleEntity>[].obs;
  var trendingArticles = <ArticleEntity>[].obs;
  var isTrendingLoading = false.obs;
  var isListLoading = false.obs;

  var selectedCategory = 'General'.obs;

  final categories = [
    'General',
    'Business',
    'Technology',
    'Sports',
    'Entertainment',
    'Health',
    'Science',
  ];

  // Pagination Vars
  var allFetchedArticles = <ArticleEntity>[];
  final int pageSize = 10;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    // Fetch both initially
    fetchTrending();
    fetchArticlesByCategory();

    // Auto-Reconnect Logic
    final networkController = Get.find<NetworkController>();
    ever(networkController.isConnected, (bool connected) {
      if (connected) {
        if (trendingArticles.isEmpty) fetchTrending();
        if (articles.isEmpty) fetchArticlesByCategory();
      }
    });

    // Infinite Scroll Listener
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        loadMore();
      }
    });
  }

  void loadMore() {
    if (isListLoading.value) return;
    if (articles.length >= allFetchedArticles.length) return;

    // Simulate loading more
    int nextCount = articles.length + pageSize;
    if (nextCount > allFetchedArticles.length) {
      nextCount = allFetchedArticles.length;
    }
    articles.addAll(allFetchedArticles.sublist(articles.length, nextCount));
  }

  void fetchTrending() async {
    isTrendingLoading.value = true;
    try {
      final result = await getTopHeadlinesUseCase('General'); // Always General
      if (result.length > 5) {
        trendingArticles.value = result.sublist(0, 5);
      } else {
        trendingArticles.value = result;
      }
    } catch (e) {
      // Slient fail or minor snackbar
    } finally {
      isTrendingLoading.value = false;
    }
  }

  void fetchArticlesByCategory() async {
    isListLoading.value = true;
    try {
      final result = await getTopHeadlinesUseCase(selectedCategory.value);
      allFetchedArticles = result;

      // If we are in General, we might want to skip the top 5 that are in trending?
      // User requested "Latest" to reload.
      // If General is selected, we usually exclude the first 5 to avoid dupes with Trending.
      // If 'Sports' is selected, we show ALL sports articles in List.

      int start = 0;
      if (selectedCategory.value == 'General') {
        start = 5; // Skip top 5
      }

      if (result.length > start) {
        var initialListSize = start + pageSize;
        if (initialListSize > result.length) initialListSize = result.length;
        articles.value = result.sublist(start, initialListSize);
      } else {
        articles.value = [];
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load news list');
    } finally {
      isListLoading.value = false;
    }
  }

  void onCategorySelected(String category) {
    selectedCategory.value = category;
    fetchArticlesByCategory(); // Only fetch list
  }

  void searchNews(String query) async {
    if (query.isEmpty) {
      fetchArticlesByCategory();
      return;
    }
    isListLoading.value = true;
    try {
      final result = await searchNewsUseCase(query);
      allFetchedArticles =
          result; // Also store search results for potential pagination if needed
      articles.value = result;
    } catch (e) {
      Get.snackbar('Error', 'Failed to search news');
    } finally {
      isListLoading.value = false;
    }
  }
}
