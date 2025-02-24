import 'package:flutter/material.dart';
import '../../models/comment_model.dart';
import '../../models/project_model.dart';
import '../components/custom_widget.dart';
import '../components/project_card.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final ProjectModel project;


  const ProjectDetailsScreen({Key? key, required this.project}) : super(key: key);

  @override
  _ProjectDetailsScreenState createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  final TextEditingController _commentController = TextEditingController();
  bool isLiked = false;
  List<CommentModel> comments = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProjectDetails();
  }

  Future<void> _loadProjectDetails() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      comments = [
        CommentModel(
          commentId: '1',
          userId: 'user1',
          text: 'Great project! Love the implementation.',
          createdAt: DateTime.now(),
        ),
      ];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'project-${widget.project.id}',
                child: UiHelper.customImage(
                  img: widget.project.imageUrl.isNotEmpty
                      ? widget.project.imageUrl
                      : ProjectCard.defaultImageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: UiHelper.customText(
                          text: widget.project.title,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          setState(() {
                            isLiked = !isLiked;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.blue[100],
                        child: UiHelper.customText(
                          text: widget.project.userName[0].toUpperCase(),
                          color: Colors.blue[700]!,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 8),
                      UiHelper.customText(
                        text: widget.project.userName,
                        color: Colors.grey[700]!,
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.project.tags.map((tag) => UiHelper.customCard(
                      child: UiHelper.customText(
                        text: tag,
                        color: Colors.blue[700]!,
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                      ),
                    )).toList(),
                  ),
                  SizedBox(height: 16),
                  UiHelper.customText(
                    text: widget.project.description,
                    color: Colors.grey[800]!,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                  SizedBox(height: 24),
                  if (widget.project.githubLink.isNotEmpty)
                    UiHelper.customButton(
                      onTapped: () {},
                      text: 'View on GitHub',
                      width: double.infinity,
                    ),
                  SizedBox(height: 24),
                  UiHelper.customText(
                    text: 'Comments',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: UiHelper.customTextField(
                          controller: _commentController,
                          hintText: 'Add a comment...',
                          icon: Icons.comment,
                        ),
                      ),
                      SizedBox(width: 8),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
