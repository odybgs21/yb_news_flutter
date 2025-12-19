import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class NewsProvider extends GetxService {
  // Using Saurav.tech NewsAPI Wrapper (No API Key Required)
  final String _baseUrl = 'https://saurav.tech/NewsAPI';

  Future<List<ArticleModel>> getTopHeadlines(String category) async {
    // Endpoints: top-headlines/category/<category>/<country>.json
    // Country default: us
    final cat = category.toLowerCase();
    final url = Uri.parse('$_baseUrl/top-headlines/category/$cat/us.json');

    print('NewsProvider: Fetching $url');

    try {
      final response = await http.get(url);

      if (response.statusCode != 200) {
        print('NewsProvider: HTTP Error ${response.statusCode}');
        return Future.error('HTTP Error: ${response.statusCode}');
      }

      final data = jsonDecode(response.body);

      if (data['status'] == 'ok') {
        final List items = data['articles'] ?? [];
        return items.map((e) => ArticleModel.fromJson(e)).toList();
      } else {
        return Future.error('API Error: ${data['code']}');
      }
    } catch (e) {
      print('NewsProvider: Exception $e');
      return Future.error(e.toString());
    }
  }

  Future<List<ArticleModel>> searchNews(String query) async {
    // Saurav.tech does not support dynamic search search queries.
    // We simulate search by fetching 'general' (or all categories if we wanted to be thorough)
    // and filtering locally.
    try {
      final articles = await getTopHeadlines('general');
      if (query.isEmpty) return articles;

      return articles
          .where((a) => a.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
