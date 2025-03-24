import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadProjectImage(File imageFile, String userId) async {
    try {
      // Generate a unique filename
      String fileName = 'projects/$userId/${DateTime.now().millisecondsSinceEpoch}.jpg';

      // Upload file to Firebase Storage
      TaskSnapshot snapshot = await _storage.ref(fileName).putFile(imageFile);

      // Get the download URL
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  /// Uploads profile image and returns the download URL
  Future<String> uploadProfileImage(String userId, File imageFile) async {
    try {
      final ref = _storage.ref().child('profile_images').child('$userId.jpg');
      await ref.putFile(imageFile);
      return await ref.getDownloadURL();
    } catch (e) {
      throw Exception("Failed to upload profile image: $e");
    }
  }
}
