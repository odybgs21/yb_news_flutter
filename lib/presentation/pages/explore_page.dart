import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/routes/app_pages.dart';
import '../widgets/news_tile.dart';
import '../controllers/news_controller.dart';

class ExplorePage extends GetView<NewsController> {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explore"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Real-Time Search Bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    onChanged: (val) => controller.searchNews(val),
                    decoration: const InputDecoration(
                      icon: Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                      hintText: "Search topics, locations...",
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Categories Grid
                const Text(
                  "Topics",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: controller.categories
                        .map((category) => _buildTopicChip(category))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 20),

                const Text(
                  "Search Results",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),

          // Connected News List
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!controller.isListLoading.value &&
                    scrollInfo.metrics.pixels >=
                        scrollInfo.metrics.maxScrollExtent - 200) {
                  controller.loadMore();
                }
                return false;
              },
              child: Obx(() {
                if (controller.isListLoading.value &&
                    controller.articles.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.articles.isEmpty) {
                  return const Center(child: Text("No articles found"));
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  // Removed shared scrollController to handle independently via NotificationListener
                  itemCount:
                      controller.articles.length +
                      (controller.isListLoading.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == controller.articles.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return NewsTile(
                      article: controller.articles[index],
                      onTap: () => Get.toNamed(
                        Routes.newsDetail,
                        arguments: controller.articles[index],
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopicChip(String label) {
    // We compare with the controller's selected value
    // Since controller.categories are capitalized in list but maybe lower in comparison?
    // The controller uses 'General', 'Sports' (Capitalized). So direct comparison is fine.

    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Obx(() {
        final isSelected = controller.selectedCategory.value == label;
        return ChoiceChip(
          label: Text(label),
          selected: isSelected,
          selectedColor: Colors.blue.withOpacity(0.2),
          labelStyle: TextStyle(
            color: isSelected ? Colors.blue : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
          onSelected: (bool selected) {
            if (selected) {
              controller.onCategorySelected(label);
            }
          },
        );
      }),
    );
  }
}
