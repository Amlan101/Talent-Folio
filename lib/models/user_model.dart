import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{

  final String id;
  final String name;
  final String email;
  final String bio;
  final List<String> skills;
  final String profilePictureUrl;
  final Timestamp createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.bio,
    required this.skills,
    required this.profilePictureUrl,
    required this.createdAt,
  });

  /// Convert Firestore data to UserModel
  factory UserModel.fromJson(Map<String, dynamic> json, String id) {
    return UserModel(
      id: id,
      name: json['name'] ?? 'No Name',
      email: json['email'] ?? 'No Email',
      bio: json['bio'] ?? '',
      skills: json['skills'] != null ? List<String>.from(json['skills']) : [],
      profilePictureUrl: json['profilePictureUrl'] ?? '',
      createdAt: json['createdAt'] ?? Timestamp.now(),
    );
  }

  /// Convert UserModel to Firestore format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'bio': bio,
      'skills': skills,
      'profilePictureUrl': profilePictureUrl,
      'createdAt': createdAt,
    };
  }

  /// Creates a new copy of UserModel with modified fields
  UserModel copyWith({
    String? name,
    String? email,
    String? bio,
    List<String>? skills,
    String? profilePictureUrl,
    Timestamp? createdAt,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      skills: skills ?? this.skills,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}