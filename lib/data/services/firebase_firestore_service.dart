import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/project_model.dart';
import '../../models/user_model.dart';

class FirebaseFirestoreService {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ProjectModel>> fetchProjects() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('projects').get();
      return snapshot.docs.map((doc) => ProjectModel.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
    } catch (e) {
      print("Error fetching projects: $e");
      return [];
    }
  }

  Future<void> addProject(ProjectModel project) async {
    try {
      DocumentReference docRef = _firestore.collection('projects').doc();
      await docRef.set({
        'id': docRef.id, // Auto-generated project ID
        'title': project.title,
        'description': project.description,
        'tags': project.tags,
        'imageUrl': project.imageUrl,
        'githubLink': project.githubLink,
        'userId': project.userId,
        'userName': project.userName,
        'createdAt': FieldValue.serverTimestamp(),
        'likesCount': 0,
        'commentsCount': 0,
      });
    } catch (e) {
      throw Exception("Error adding project: $e");
    }
  }

  /// Add new user to Firestore
  Future<void> createUser(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.id).set(user.toJson());
    } catch (e) {
      throw Exception("Error creating user: $e");
    }
  }

  /// Fetch user by ID
  Future<UserModel?> getUserById(String userId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(userId).get();
      if (!doc.exists) return null;
      return UserModel.fromJson(doc.data() as Map<String, dynamic>, doc.id);
    } catch (e) {
      throw Exception("Error fetching user: $e");
    }
  }
}
