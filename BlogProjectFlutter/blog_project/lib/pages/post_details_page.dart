import 'package:flutter/material.dart';
import 'package:blog_project/services/api_service.dart';
import 'package:blog_project/models/post.dart';
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
      appBar: AppBar(title: const Text('Détails de l\'article')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _post == null
          ? const Center(child: Text('Article non trouvé'))
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _post!.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Publié le ${DateFormat('dd/MM/yyyy').format(_post!.createdAt)}',
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  if (_post!.imageUrl != null)
                    Image.network(
                      'https://blog-backend-kf3i.onrender.com${_post!.imageUrl!}',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  const SizedBox(height: 16),
                  Text(_post!.content, style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
    );
  }
}
