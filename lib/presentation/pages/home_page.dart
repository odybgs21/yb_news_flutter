import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/news_controller.dart';
import '../controllers/home_controller.dart';
import '../../app/routes/app_pages.dart';
import '../widgets/news_tile.dart';
import '../widgets/trending_card.dart';

// Import new pages
import 'explore_page.dart';
import 'bookmark_page.dart';
import 'profile_page.dart';

class HomePage extends GetView<NewsController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // We need HomeController for tab management
    final homeController = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Obx(() {
            switch (homeController.bottomNavIndex.value) {
              case 0:
                return _buildHomeView(context);
              case 1:
                return const ExplorePage();
              case 2:
                return const BookmarkPage();
              case 3:
                return const ProfilePage();
              default:
                return _buildHomeView(context);
            }
          }),
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: homeController.bottomNavIndex.value,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              label: "Explore",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_outline),
              label: "Bookmark",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: "Profile",
            ),
          ],
          onTap: (index) => homeController.changeTabIndex(index),
        ),
      ),
    );
  }

  // Original Home Body Logic moved here
  Widget _buildHomeView(BuildContext context) {
    return Column(
      children: [
        // App Bar extracted or simulated
        _buildHomeAppBar(),
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: _buildSearchBar(context),
                  ),
                  // Trending Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Trending",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () => Get.toNamed(Routes.trending),
                          child: const Text("See all"),
                        ),
                      ],
                    ),
                  ),

                  // Trending List
                  SizedBox(
                    height: 340, // Increased to Prevent Overflow
                    child: Obx(() {
                      if (controller.isTrendingLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: controller.trendingArticles.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 300,
                            margin: const EdgeInsets.only(right: 16),
                            child: TrendingCard(
                              article: controller.trendingArticles[index],
                              onTap: () => Get.toNamed(
                                Routes.newsDetail,
                                arguments: controller.trendingArticles[index],
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),

                  const SizedBox(height: 10),

                  // Latest Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Latest",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () => Get.toNamed(Routes.newsList),
                          child: const Text("See all"),
                        ),
                      ],
                    ),
                  ),

                  // Categories
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Obx(
                      () => Row(
                        children: controller.categories
                            .map(
                              (category) => _buildCategoryChip(
                                category,
                                controller.selectedCategory.value == category,
                                () => controller.onCategorySelected(category),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Latest List (Vertical)
                  Obx(() {
                    final list = controller.articles;
                    // If loading and list is empty, show spinner
                    if (controller.isListLoading.value && list.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount:
                          list.length +
                          (controller.isListLoading.value ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == list.length) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return NewsTile(
                          article: list[index],
                          onTap: () => Get.toNamed(
                            Routes.newsDetail,
                            arguments: list[index],
                          ),
                        );
                      },
                    );
                  }),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  PreferredSizeWidget _buildHomeAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Container(),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Redirect to Explore Page (Index 1) for search
        Get.find<HomeController>().changeTabIndex(1);
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey.shade300),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.black45),
            const SizedBox(width: 10),
            const Text(
              "Search",
              style: TextStyle(color: Colors.black45, fontSize: 16),
            ),
            const Spacer(),
            const Icon(Icons.tune, color: Colors.black45), // Filter icon
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        selectedColor: Colors.blue.withOpacity(0.2),
        labelStyle: TextStyle(
          color: isSelected ? Colors.blue : Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        onSelected: (bool selected) {
          if (selected) {
            onTap();
          }
        },
      ),
    );
  }
}

class NewsSearchDelegate extends SearchDelegate {
  final NewsController controller;
  NewsSearchDelegate(this.controller);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    controller.searchNews(query);
    Get.toNamed(Routes.newsList);
    close(context, null);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
