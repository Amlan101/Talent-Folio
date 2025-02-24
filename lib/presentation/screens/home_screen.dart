import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:talentfolio/presentation/screens/project_detail_screen.dart';
import '../../models/project_model.dart';
import '../components/custom_widget.dart';
import '../components/project_card.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  final String userName;

  HomeScreen({super.key, required this.userName});

  // Static list of projects (Replace with Firebase fetching later)
  final List<ProjectModel> projects = [
    ProjectModel(
      id: '1',
      title: 'AI-Powered Chatbot',
      description: 'A chatbot that uses AI to answer queries intelligently.',
      tags: ['AI', 'Chatbot', 'Machine Learning'],
      imageUrl: 'https://via.placeholder.com/300',
      githubLink: 'https://github.com/johndoe/chatbot',
      userId: 'user1',
      createdAt: Timestamp.now(),
      likesCount: 120,
      commentsCount: 35,
      userName: 'John Doe',
    ),
    ProjectModel(
      id: '2',
      title: 'E-Commerce App',
      description: 'A full-fledged e-commerce mobile application.',
      tags: ['Flutter', 'E-Commerce', 'Mobile App'],
      imageUrl: 'https://via.placeholder.com/300',
      githubLink: 'https://github.com/alicesmith/ecommerce-app',
      userId: 'user2',
      createdAt: Timestamp.now(),
      likesCount: 200,
      commentsCount: 50,
      userName: 'Alice Smith',
    ),
    ProjectModel(
      id: '3',
      title: 'Weather App',
      description: 'A simple weather app that fetches live weather data.',
      tags: ['Weather', 'API', 'Flutter'],
      imageUrl: 'https://via.placeholder.com/300',
      githubLink: 'https://github.com/bobjohnson/weather-app',
      userId: 'user3',
      createdAt: Timestamp.now(),
      likesCount: 80,
      commentsCount: 20,
      userName: 'Bob Johnson',
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: UiHelper.customText(
          text: "Hello, $userName",
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UiHelper.customSearchField(controller: searchController),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  return ProjectCard(
                    project: projects[index],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProjectDetailsScreen(project: projects[index]),
                          ),
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
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

