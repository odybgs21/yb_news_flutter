import '../models/article_model.dart';

class MockNewsProvider {
  // Simulate delay
  Future<void> _delay() async =>
      await Future.delayed(const Duration(seconds: 1));

  final List<Map<String, dynamic>> _mockArticles = [
    {
      "source": {"id": "wired", "name": "Wired"},
      "author": "Joel Khalili",
      "title": "Crypto Is Playing the 2024 Election",
      "description":
          "The cryptocurrency industry is pouring money into the 2024 US election to defeat skeptics and elect allies.",
      "url": "https://www.wired.com/story/crypto-2024-election-super-pac/",
      "urlToImage":
          "https://media.wired.com/photos/65a6e00976156e542938061e/191:100/w_1280,c_limit/Crypto-Election-Business-1288593450.jpg",
      "publishedAt": "2024-01-19T12:00:00Z",
      "content": "In the final weeks of 2023, a super PAC called Fairshake...",
    },
    {
      "source": {"id": "the-verge", "name": "The Verge"},
      "author": "Tom Warren",
      "title": "Microsoft's AI Push",
      "description": "Microsoft is integrating Copilot into everything.",
      "url": "https://www.theverge.com",
      "urlToImage": "https://cdn.vox-cdn.com/thumbor/ExampleImage.jpg",
      "publishedAt": "2024-01-18T10:00:00Z",
      "content": "Microsoft is pushing AI...",
    },
    {
      "source": {"id": "bbc", "name": "BBC News"},
      "author": "BBC",
      "title": "Global Markets Rally",
      "description": "Stocks hit record highs as inflation cools.",
      "url": "https://www.bbc.com",
      "urlToImage": "https://ichef.bbci.co.uk/news/976/cpsprodpb/Example.jpg",
      "publishedAt": "2024-01-20T09:00:00Z",
      "content": "Global markets are rallying...",
    },
    {
      "source": {"id": "espn", "name": "ESPN"},
      "author": "ESPN",
      "title": "NBA Finals Preview",
      "description":
          "The Celtics face the Nuggets in a potential finals matchup.",
      "url": "https://www.espn.com",
      "urlToImage": "https://a.espncdn.com/photo/Example.jpg",
      "publishedAt": "2024-01-21T15:00:00Z",
      "content": "The Celtics are looking strong...",
    },
  ];

  Future<List<ArticleModel>> getTopHeadlines(String category) async {
    await _delay();
    // Simulate filtering (very basic)
    if (category != 'General') {
      return _mockArticles
          .where(
            (a) =>
                (a['title'] as String).contains(category) ||
                (a['description'] as String).contains(category),
          )
          .map((json) => ArticleModel.fromJson(json))
          .toList();
    }
    return _mockArticles.map((json) => ArticleModel.fromJson(json)).toList();
  }

  Future<List<ArticleModel>> searchNews(String query) async {
    await _delay();
    return _mockArticles
        .where(
          (a) => (a['title'] as String).toLowerCase().contains(
            query.toLowerCase(),
          ),
        )
        .map((json) => ArticleModel.fromJson(json))
        .toList();
  }
}
