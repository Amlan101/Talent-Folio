import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:talentfolio/presentation/screens/home_screen.dart';
import 'package:talentfolio/presentation/screens/login_screen.dart';

import 'data/services/firebase_firestore_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: AuthChecker());
  }
}

class AuthChecker extends StatelessWidget {
  final FirebaseFirestoreService _firestoreService = FirebaseFirestoreService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return LoginScreen();
          } else {
            // Fetching user details from Firestore to display the name at the top
            return FutureBuilder(
              future: _firestoreService.getUserById(user.uid),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (userSnapshot.hasError || userSnapshot.hasData == null) {
                  return HomeScreen(userName: "Unknown User");
                } else {
                  return HomeScreen(userName: userSnapshot.data!.name);
                }
              },
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
