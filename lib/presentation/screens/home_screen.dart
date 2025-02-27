import 'package:flutter/material.dart';
import 'package:talentfolio/presentation/screens/add_project_screen.dart';
import 'package:talentfolio/presentation/screens/project_detail_screen.dart';

import '../../data/services/firebase_firestore_service.dart';
import '../../models/project_model.dart';
import '../components/custom_widget.dart';
import '../components/project_card.dart';

class HomeScreen extends StatefulWidget {
  final String userName;

  HomeScreen({super.key, required this.userName});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestoreService _firestoreService = FirebaseFirestoreService();
  late Future<List<ProjectModel>> _projectsFuture;

  @override
  void initState() {
    super.initState();
    _projectsFuture = _firestoreService.fetchProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: UiHelper.customText(
          text: "Hello, ${widget.userName}",
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {}, // TODO: Implement profile screen
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UiHelper.customSearchField(controller: TextEditingController()),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<ProjectModel>>(
                future: _projectsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No projects found.'));
                  }

                  final projects = snapshot.data!;
                  return ListView.builder(
                    itemCount: projects.length,
                    itemBuilder: (context, index) {
                      return ProjectCard(
                        project: projects[index],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => ProjectDetailsScreen(
                                    project: projects[index],
                                  ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNewProjectScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
