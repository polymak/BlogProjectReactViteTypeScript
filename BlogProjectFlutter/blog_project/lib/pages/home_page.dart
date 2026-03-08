import 'package:flutter/material.dart';
import 'package:blog_project/services/api_service.dart';
import 'package:blog_project/models/post.dart';
import 'package:blog_project/widgets/article_card.dart';
import 'package:blog_project/widgets/section_header.dart';
import 'package:blog_project/widgets/bottom_nav.dart';
import 'package:blog_project/widgets/app_menu_overlay.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService _apiService = ApiService();
  List<Post> _posts = [];
  bool _isLoading = true;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    setState(() {
      _isLoading = true;
    });

    final posts = await _apiService.getPosts();
    setState(() {
      _posts = posts;
      _isLoading = false;
    });
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  String _formatTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inHours < 1) {
      return 'Il y a ${difference.inMinutes} minutes';
    } else if (difference.inHours < 24) {
      return 'Il y a ${difference.inHours} heures';
    } else if (difference.inDays < 7) {
      return 'Hier';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void _showMenu(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, __, ___) => AppMenuOverlay(
          onHomeTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/');
          },
          onLoginTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/login');
          },
          onSubscribeTap: () {
            // Subscribe button action (visual only)
          },
          onClose: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'Mon Blog',
          style: TextStyle(
            color: Color(0xFF1976D2),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFF333333)),
            onPressed: () {
              _showMenu(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 80),
        child: Column(
          children: [
            // Section header
            const SectionHeader(
              title: 'Articles récents',
              subtitle: 'Cliquez sur un article pour lire son contenu complet.',
            ),

            // Articles list
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _posts.isEmpty
                ? const Center(child: Text('Aucun article pour le moment'))
                : Column(
                    children: _posts.map((post) {
                      return ArticleCard(
                        category: 'ACTUALITÉ',
                        time: _formatTime(post.createdAt),
                        title: post.title,
                        summary: post.content.length > 100
                            ? '${post.content.substring(0, 100)}...'
                            : post.content,
                        author: 'Admin',
                        imageUrl:
                            post.imageUrl ??
                            'https://via.placeholder.com/400x200',
                        onTap: () {
                          Navigator.pushNamed(context, '/posts/${post.id}');
                        },
                      );
                    }).toList(),
                  ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
      ),
    );
  }
}
