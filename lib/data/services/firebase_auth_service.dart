import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/user_model.dart';

class FirebaseAuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign Up with Email & Password
  Future<UserModel?> signUp({
    required String name,
    required String email,
    required String password
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        UserModel newUser = UserModel(
          id: user.uid,
          name: name,
          email: email,
          bio: '',
          skills: [],
          profilePictureUrl: '',
          createdAt: Timestamp.now(),
        );

        await _firestore.collection('users').doc(user.uid).set(newUser.toJson());

        return newUser;
      }
      return null;

    } catch (e) {
      print("Sign Up Error: $e");
      return null;
    }
  }

  // Sign In with Email & Password
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Sign In Error: $e");
      return null;
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get Current User
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Stream to Listen for Auth State Changes
  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }
}
