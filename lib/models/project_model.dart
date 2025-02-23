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
    this.likesCount = 0,
    this.commentsCount = 0,
    required this.userName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'tags': tags,
      'imageUrl': imageUrl,
      'githubLink': githubLink,
      'userId': userId,
      'createdAt': createdAt,
      'likesCount': likesCount,
      'commentsCount': commentsCount,
      'userName': userName,
    };
  }

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      tags: List<String>.from(map['tags']),
      imageUrl: map['imageUrl'],
      githubLink: map['githubLink'],
      userId: map['userId'],
      createdAt: map['createdAt'],
      likesCount: map['likesCount'] ?? 0,
      commentsCount: map['commentsCount'] ?? 0,
      userName: map['userName'] ?? 'Unknown User',
    );
  }
}
