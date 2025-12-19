import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/article_entity.dart';

class BookmarkController extends GetxController {
  final bookmarks = <ArticleEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Re-load bookmarks when controller initializes (e.g. user switch)
    loadBookmarks();
  }

  void toggleBookmark(ArticleEntity article) {
    if (isBookmarked(article)) {
      bookmarks.removeWhere((a) => a.title == article.title);
      Get.snackbar('Removed', 'Article removed from bookmarks');
    } else {
      bookmarks.add(article);
      Get.snackbar('Saved', 'Article added to bookmarks');
    }
    saveBookmarks();
  }

  bool isBookmarked(ArticleEntity article) {
    return bookmarks.any((a) => a.title == article.title);
  }

  // Persistence Logic
  Future<String> _getStorageKey() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('user_email');
    if (email == null) return 'bookmarks_guest';
    return 'bookmarks_$email';
  }

  void saveBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final key = await _getStorageKey();

    final String data = jsonEncode(
      bookmarks.map((e) => _entityToMap(e)).toList(),
    );
    await prefs.setString(key, data);
  }

  Future<void> loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final key = await _getStorageKey();

    final String? data = prefs.getString(key);
    if (data != null) {
      final List<dynamic> decoded = jsonDecode(data);
      final List<ArticleEntity> loaded = decoded
          .map((e) => _mapToEntity(e))
          .toList();
      bookmarks.assignAll(loaded);
    } else {
      bookmarks.clear(); // Clear if no data for this user
    }
  }

  Map<String, dynamic> _entityToMap(ArticleEntity e) {
    return {
      'title': e.title,
      'description': e.description,
      'urlToImage': e.urlToImage,
      'publishedAt': e.publishedAt,
      'content': e.content,
      'source': e.source,
      'url': e.url,
    };
  }

  ArticleEntity _mapToEntity(Map<String, dynamic> m) {
    return ArticleEntity(
      title: m['title'] ?? '',
      description: m['description'] ?? '',
      urlToImage: m['urlToImage'] ?? '',
      publishedAt: m['publishedAt'] ?? '',
      content: m['content'] ?? '',
      source: m['source'] ?? '',
      url: m['url'] ?? '',
    );
  }
}
