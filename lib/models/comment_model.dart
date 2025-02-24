import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String? commentId;
  final String userId;
  final String text;
  final DateTime? createdAt;

  CommentModel({
    this.commentId,
    required this.userId,
    required this.text,
    this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'commentId': commentId,
      'userId': userId,
      'text': text,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
    };
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      commentId: json['commentId'],
      userId: json['userId'],
      text: json['text'],
      createdAt: json['createdAt'] != null ? (json['createdAt'] as Timestamp).toDate() : null,
    );
  }
}
