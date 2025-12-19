import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/article_entity.dart';
import '../../app/routes/app_pages.dart';
import '../../presentation/controllers/bookmark_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class NewsDetailPage extends StatelessWidget {
  const NewsDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ArticleEntity article = Get.arguments as ArticleEntity;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.black),
            onPressed: () {
              Share.share(article.url, subject: article.title);
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Source Header
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: const Color(
                              0xFFC00000,
                            ), // BBC Red-ish
                            radius: 20,
                            child: Text(
                              article.source.isNotEmpty
                                  ? article.source[0]
                                  : 'N',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                article.source,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                _formatTime(article.publishedAt),
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          article.urlToImage,
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                height: 250,
                                color: Colors.grey[300],
                                child: const Icon(Icons.broken_image, size: 50),
                              ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Category
                      Text(
                        "Europe", // Mock category
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Title
                      Text(
                        article.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Description / Content
                      Text(
                        article.description,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        article
                            .content, // Often truncated in free API, but displaying what we have
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const SizedBox(height: 24),

                      // Read Full Story Button
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            print("Attempting to launch: '${article.url}'");
                            if (article.url.isEmpty) {
                              Get.snackbar(
                                "Error",
                                "No URL available for this article",
                              );
                              return;
                            }
                            try {
                              final uri = Uri.parse(article.url);
                              if (await canLaunchUrl(uri)) {
                                await launchUrl(uri);
                              } else {
                                print("Cannot launch URL: $uri");
                                // Fallback for some devices/browsers
                                await launchUrl(
                                  uri,
                                  mode: LaunchMode.externalApplication,
                                );
                              }
                            } catch (e) {
                              print("Error launching URL: $e");
                              Get.snackbar("Error", "Could not open link");
                            }
                          },
                          icon: const Icon(Icons.open_in_new),
                          label: const Text("Read Full Story"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),

              // Bottom Reaction Bar
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Colors.grey[200]!)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.favorite, color: Colors.pink),
                    const SizedBox(width: 8),
                    const Text(
                      "24.5K",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 24),
                    InkWell(
                      onTap: () => Get.toNamed(Routes.comments),
                      child: Row(
                        children: const [
                          Icon(Icons.chat_bubble_outline, color: Colors.black),
                          SizedBox(width: 8),
                          Text(
                            "1K",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Obx(() {
                      final bookmarkController = Get.find<BookmarkController>();
                      final isBookmarked = bookmarkController.isBookmarked(
                        article,
                      );
                      return IconButton(
                        icon: Icon(
                          isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                          color: isBookmarked ? Colors.blue : Colors.grey,
                        ),
                        onPressed: () {
                          bookmarkController.toggleBookmark(article);
                        },
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(String publishedAt) {
    try {
      final date = DateTime.parse(publishedAt);
      final diff = DateTime.now().difference(date);
      if (diff.inHours > 0) return '${diff.inHours}h ago';
      if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
      return 'Just now';
    } catch (e) {
      return 'recently';
    }
  }
}
