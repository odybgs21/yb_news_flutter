import 'package:flutter/material.dart';
import '../../domain/entities/article_entity.dart';

class TrendingCard extends StatelessWidget {
  final ArticleEntity article;
  final VoidCallback onTap;

  const TrendingCard({super.key, required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    article.urlToImage,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image_not_supported, size: 50),
                    ),
                  ),
                ),
                // Overlay gradient if needed? Design shows text below usually, but image implies maybe overlay?
                // The uploaded design shows text BELOW the image for the Trending item "Russian warship..."
                // So I will put text below.
              ],
            ),
            const SizedBox(height: 12),
            Text(
              "Europe", // Mock category/region
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
            const SizedBox(height: 8),
            Text(
              article.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                CircleAvatar(
                  // Mock logo
                  radius: 10,
                  backgroundColor: Colors.red,
                  child: Text(
                    article.source[0],
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  article.source,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 12),
                const Icon(Icons.access_time, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  _formatTime(article.publishedAt),
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const ConstSpacer(),
                // Menu dots
                const Icon(Icons.more_horiz, color: Colors.grey),
              ],
            ),
          ],
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

// Helper spacer
class ConstSpacer extends StatelessWidget {
  const ConstSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Spacer();
  }
}
