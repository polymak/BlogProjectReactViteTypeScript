import 'package:flutter/material.dart';
import 'package:blog_project/services/api_service.dart';
import 'package:blog_project/services/image_upload_service.dart';
import 'package:blog_project/models/post.dart';
import 'package:blog_project/pages/post_details_page.dart';
import 'package:blog_project/widgets/blog_list_header.dart';
import 'package:blog_project/widgets/add_article_card.dart';
import 'package:blog_project/widgets/article_table_card.dart';
import 'package:blog_project/widgets/admin_bottom_nav.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

class BlogListPage extends StatefulWidget {
  const BlogListPage({Key? key}) : super(key: key);

  @override
  State<BlogListPage> createState() => _BlogListPageState();
}

class _BlogListPageState extends State<BlogListPage> {
  final ApiService _apiService = ApiService();
  List<Post> _posts = [];
  bool _isLoading = true;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  File? _imageFile;

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

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _createPost() async {
    if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez remplir tous les champs'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    String? imageUrl = null;

    // Upload image if selected
    if (_imageFile != null) {
      print(
        'BlogListPage: Starting image upload for file: ${_imageFile!.path}',
      );
      final uploadService = ImageUploadService();
      imageUrl = await uploadService.uploadImage(_imageFile!);
      print('BlogListPage: Image upload result: $imageUrl');

      if (imageUrl == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erreur lors de l\'upload de l\'image'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    print('BlogListPage: Creating post with imageUrl: $imageUrl');
    final post = await _apiService.createPost(
      _titleController.text,
      _contentController.text,
      imageUrl,
    );

    if (post != null) {
      _titleController.clear();
      _contentController.clear();
      _imageFile = null;
      await _loadPosts();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Article créé avec succès'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erreur lors de la création de l\'article'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _deletePost(int id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmer la suppression'),
        content: const Text('Êtes-vous sûr de vouloir supprimer cet article ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final success = await _apiService.deletePost(id);
      if (success) {
        await _loadPosts();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Article supprimé avec succès'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erreur lors de la suppression'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _editPost(int id) async {
    final post = await _apiService.getPost(id);
    if (post == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Article non trouvé'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Fill form with existing data
    _titleController.text = post.title;
    _contentController.text = post.content;
    _imageFile = null; // Image would need to be handled separately

    // Navigate to edit mode or show edit form
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Formulaire prérempli avec les données existantes'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Future<void> _updatePost(int id) async {
    if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez remplir tous les champs'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    String? imageUrl = null;

    // Upload new image if selected
    if (_imageFile != null) {
      print(
        'BlogListPage: Starting image upload for edit: ${_imageFile!.path}',
      );
      final uploadService = ImageUploadService();
      imageUrl = await uploadService.uploadImage(_imageFile!);
      print('BlogListPage: Image upload result for edit: $imageUrl');

      if (imageUrl == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erreur lors de l\'upload de l\'image'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    print('BlogListPage: Updating post with imageUrl: $imageUrl');
    final post = await _apiService.updatePost(
      id,
      _titleController.text,
      _contentController.text,
      imageUrl,
    );

    if (post != null) {
      _titleController.clear();
      _contentController.clear();
      _imageFile = null;
      await _loadPosts();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Article mis à jour avec succès'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erreur lors de la mise à jour de l\'article'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              const BlogListHeader(),

              const SizedBox(height: 16),

              // Add article card
              AddArticleCard(
                titleController: _titleController,
                contentController: _contentController,
                selectedFileName: _imageFile?.path.split('/').last,
                onFileSelect: _pickImage,
                onAddArticle: _createPost,
                isLoading: false,
              ),

              const SizedBox(height: 16),

              // Articles table
              ArticleTableCard(
                articles: _posts,
                isLoading: _isLoading,
                onRefresh: _loadPosts,
                onEdit: (post) => _editPost(post.id),
                onDelete: (post) => _deletePost(post.id),
              ),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),

      // Bottom navigation
      bottomNavigationBar: AdminBottomNav(
        currentIndex: 2,
        onTap: (index) {
          // Navigation logic would go here
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Navigate to $index')));
        },
      ),
    );
  }
}
