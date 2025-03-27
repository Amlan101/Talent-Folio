import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talentfolio/presentation/screens/login_screen.dart';
import 'package:talentfolio/presentation/screens/project_detail_screen.dart';

import '../../data/services/firebase_firestore_service.dart';
import '../../data/services/firebase_storage_service.dart';
import '../../models/project_model.dart';
import '../../models/user_model.dart';
import '../components/custom_widget.dart';
import '../components/project_card.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseFirestoreService _firestoreService = FirebaseFirestoreService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel? _user;
  List<ProjectModel> _userProjects = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    String userId = _auth.currentUser?.uid ?? "";
    if (userId.isEmpty) return;

    try {
      UserModel? user = await _firestoreService.getUserById(userId);

      // Fetch user's projects
      List<ProjectModel> projects = await _firestoreService.fetchProjects();
      List<ProjectModel> userProjects =
          projects.where((p) => p.userId == userId).toList();

      setState(() {
        _user = user;
        _userProjects = userProjects;
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching profile: $e");
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
        SliverAppBar(
        expandedHeight: 250,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: const EdgeInsets.only(bottom: 16.0),
          title: Center(
            child: Text(
              _user?.name ?? "Unknown User",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          background: Stack(
            fit: StackFit.expand,
            children: [
              // Background gradient
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blue.shade400,
                      Colors.blue.shade700,
                    ],
                  ),
                ),
              ),
              // Profile Avatar
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: UiHelper.customProfileAvatar(
                    imageUrl: _user?.profilePictureUrl ?? "",
                    radius: 70,
                    onEditTap: () async {
                      final ImagePicker picker = ImagePicker();
                      XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

                      if (pickedFile != null) {
                        File imageFile = File(pickedFile.path);
                        String userId = _user?.id ?? "";

                        if (userId.isNotEmpty) {
                          String? imageUrl = await FirebaseStorageService().uploadProfileImage(userId, imageFile);

                          await FirebaseFirestore.instance.collection('users').doc(userId).update({'profilePictureUrl': imageUrl});

                          setState(() {
                            _user = _user?.copyWith(profilePictureUrl: imageUrl);
                          });
                        }
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
          // User Details Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _user?.name ?? "Unknown User",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _user?.email ?? "No Email",
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _user?.bio ?? "No bio",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 16),

                  // Stats Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      UiHelper.customStatDisplay(
                        label: "Projects",
                        value: _userProjects.length,
                        icon: Icons.work,
                      ),
                      UiHelper.customStatDisplay(
                        label: "Skills",
                        value: _user?.skills.length ?? 0,
                        icon: Icons.engineering,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Skills Section
                  const Text(
                    "Skills",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  UiHelper.customSkillChips(skills: _user?.skills ?? []),

                  const SizedBox(height: 16),

                  // Edit Profile Button
                  UiHelper.customButton(
                    text: "Edit Profile",
                    onTapped: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfileScreen(user: _user!),
                        ),
                      );
                    },
                    width: double.infinity,
                  ),
                ],
              ),
            ),
          ),

          // Projects Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "My Projects",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _userProjects.isEmpty
                      ? Center(
                        child: Text(
                          "No projects yet",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      )
                      : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _userProjects.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: ProjectCard(
                              project: _userProjects[index],
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => ProjectDetailsScreen(
                                          project: _userProjects[index],
                                        ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
