import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentModel {
  final String id;
  final String name;
  final String avatarUrl; // We'll use a placeholder or local asset logic
  final String content;
  final String timeAgo;
  final int likes;
  final int replyCount;
  final bool isLiked;

  CommentModel({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.content,
    required this.timeAgo,
    this.likes = 0,
    this.replyCount = 0,
    this.isLiked = false,
  });
}

class CommentsController extends GetxController {
  final commentInputController = TextEditingController();

  // Mock Data
  var comments = <CommentModel>[
    CommentModel(
      id: '1',
      name: 'Wilson Franci',
      avatarUrl: 'https://i.pravatar.cc/150?u=1',
      content:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      timeAgo: '4w',
      likes: 125,
      replyCount: 2,
    ),
    CommentModel(
      id: '2',
      name: 'Madelyn Saris',
      avatarUrl: 'https://i.pravatar.cc/150?u=2',
      content: 'Lorem Ipsum is simply dummy text of the printing and type...',
      timeAgo: '4w',
      likes: 3,
      replyCount: 0,
    ),
    CommentModel(
      id: '3',
      name: 'Marley Botosh',
      avatarUrl: 'https://i.pravatar.cc/150?u=3',
      content:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      timeAgo: '4w',
      likes: 12,
      replyCount: 2,
    ),
    CommentModel(
      id: '4',
      name: 'Alfonso Septimus',
      avatarUrl: 'https://i.pravatar.cc/150?u=4',
      content:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      timeAgo: '4w',
      likes: 14000, // 14K
      replyCount: 58,
    ),
    CommentModel(
      id: '5',
      name: 'Omar Herwitz',
      avatarUrl: 'https://i.pravatar.cc/150?u=5',
      content:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      timeAgo: '4w',
      likes: 16,
      replyCount: 0,
    ),
  ].obs;

  void addComment() {
    final text = commentInputController.text.trim();
    if (text.isEmpty) return;

    comments.insert(
      0,
      CommentModel(
        id: DateTime.now().toString(),
        name: 'You', // Current user
        avatarUrl: '', // No avatar for now
        content: text,
        timeAgo: 'Just now',
        likes: 0,
      ),
    );

    commentInputController.clear();
  }
}
