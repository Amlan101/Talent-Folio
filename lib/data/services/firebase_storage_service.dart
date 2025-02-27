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
}
