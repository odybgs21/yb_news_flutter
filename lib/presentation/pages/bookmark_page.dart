import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/bookmark_controller.dart';
import '../../app/routes/app_pages.dart';

class BookmarkPage extends GetView<BookmarkController> {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmarks"),
        // actions: [
        //   IconButton(onPressed: () {}, icon: const Icon(Icons.delete_outline)),
        // ],
      ),
      body: Obx(() {
        if (controller.bookmarks.isEmpty) {
          return const Center(child: Text("No bookmarks yet."));
        }
        return ListView.builder(
          itemCount: controller.bookmarks.length,
          itemBuilder: (context, index) {
            final article = controller.bookmarks[index];
            return ListTile(
              leading: SizedBox(
                width: 60,
                child: Image.network(
                  article.urlToImage,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.image),
                ),
              ),
              title: Text(
                article.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(article.source),
              onTap: () => Get.toNamed(Routes.newsDetail, arguments: article),
              trailing: IconButton(
                icon: const Icon(Icons.bookmark_remove, color: Colors.red),
                onPressed: () => controller.toggleBookmark(article),
              ),
            );
          },
        );
      }),
    );
  }
}
