import 'package:flutter/material.dart';
import 'package:blog_project/services/api_service.dart';
import 'package:blog_project/models/post.dart';
import 'package:blog_project/widgets/article_header.dart';
import 'package:blog_project/widgets/article_meta.dart';
import 'package:blog_project/widgets/article_body.dart';
import 'package:blog_project/widgets/quote_block.dart';
import 'package:blog_project/widgets/tag_list.dart';
import 'package:blog_project/widgets/bottom_nav.dart';
import 'package:intl/intl.dart';

class PostDetailsPage extends StatefulWidget {
  final int? postId;

  const PostDetailsPage({Key? key, this.postId}) : super(key: key);

  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  final ApiService _apiService = ApiService();
  Post? _post;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    if (widget.postId != null) {
      _loadPost(widget.postId!);
    }
  }

  Future<void> _loadPost(int id) async {
    setState(() {
      _isLoading = true;
    });

    final post = await _apiService.getPost(id);
    setState(() {
      _post = post;
      _isLoading = false;
    });
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF333333)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _post == null
          ? const Center(child: Text('Article non trouvé'))
          : SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Article header
                  ArticleHeader(imageUrl: _post!.imageUrl, title: _post!.title),

                  // Article meta
                  ArticleMeta(
                    author: 'Admin',
                    date: _post!.createdAt,
                    readingTime: '5 min',
                  ),

                  // Article body
                  ArticleBody(content: _post!.content),

                  // Quote block (example - would come from API)
                  // QuoteBlock(quote: 'Citation inspirante de l\'article'),

                  // Tags (example - would come from API)
                  // TagList(tags: ['Technologie', 'Actualité']),
                ],
              ),
            ),
      bottomNavigationBar: BottomNav(
        currentIndex: 0,
        onTap: (index) {
          // Handle navigation
        },
      ),
    );
  }
}
