import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectModel {
  final String id;
  final String title;
  final String description;
  final List<String> tags;
  final String imageUrl;
  final String githubLink;
  final String userId;
  final Timestamp createdAt;
  final int likesCount;
  final int commentsCount;
  final String userName;

  ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.tags,
    required this.imageUrl,
    required this.githubLink,
    required this.userId,
    required this.createdAt,
    required this.likesCount,
    required this.commentsCount,
    required this.userName,
  });

  factory ProjectModel.fromMap(Map<String, dynamic> map, String docId) {
    return ProjectModel(
      id: docId,
      title: map['title'] ?? 'No Title',
      description: map['description'] ?? 'No description',
      tags: List<String>.from(map['tags'] ?? []),
      imageUrl: map['imageUrl'] ?? '',
      githubLink: map['githubUrl'] ?? '',
      userId: map['userId'] ?? '',
      createdAt: map['createdAt'] ?? Timestamp.now(),
      likesCount: (map['likesCount'] is int) ? map['likesCount'] : int.tryParse(map['likesCount']?.toString() ?? '0') ?? 0,
      commentsCount: (map['commentsCount'] is int) ? map['commentsCount'] : int.tryParse(map['commentsCount']?.toString() ?? '0') ?? 0,
      userName: map['userName'] ?? 'Unknown User',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'tags': tags,
      'imageUrl': imageUrl,
      'githubUrl': githubLink,
      'userId': userId,
      'createdAt': createdAt,
      'likesCount': likesCount,
      'commentsCount': commentsCount,
      'userName': userName,
    };
  }
}
