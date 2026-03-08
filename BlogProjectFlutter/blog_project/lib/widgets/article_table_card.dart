import 'package:flutter/material.dart';
import 'package:blog_project/models/post.dart';

class ArticleTableCard extends StatelessWidget {
  final List<Post> articles;
  final bool isLoading;
  final VoidCallback onRefresh;
  final ValueChanged<Post> onEdit;
  final ValueChanged<Post> onDelete;

  const ArticleTableCard({
    Key? key,
    required this.articles,
    required this.isLoading,
    required this.onRefresh,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                const Text(
                  'Articles récents',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: onRefresh,
                  icon: const Icon(Icons.refresh),
                  color: const Color(0xFF1976D2),
                ),
              ],
            ),
          ),

          // Table header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
              color: Color(0xFFF5F5F5),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: const [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Titre',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF666666),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    'Contenu',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF666666),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Image',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF666666),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Action',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF666666),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          isLoading
              ? const _LoadingState()
              : articles.isEmpty
              ? const _EmptyState()
              : _ArticleList(
                  articles: articles,
                  onEdit: onEdit,
                  onDelete: onDelete,
                ),
        ],
      ),
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: const Center(
        child: CircularProgressIndicator(color: Color(0xFF1976D2)),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: const Center(
        child: Text(
          'Aucun article pour le moment',
          style: TextStyle(fontSize: 14, color: Color(0xFF999999)),
        ),
      ),
    );
  }
}

class _ArticleList extends StatelessWidget {
  final List<Post> articles;
  final ValueChanged<Post> onEdit;
  final ValueChanged<Post> onDelete;

  const _ArticleList({
    Key? key,
    required this.articles,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        return _ArticleRow(
          article: article,
          onEdit: onEdit,
          onDelete: onDelete,
        );
      },
    );
  }
}

class _ArticleRow extends StatelessWidget {
  final Post article;
  final ValueChanged<Post> onEdit;
  final ValueChanged<Post> onDelete;

  const _ArticleRow({
    Key? key,
    required this.article,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: [
          // Title
          Expanded(
            flex: 3,
            child: Text(
              article.title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Content
          Expanded(
            flex: 4,
            child: Text(
              article.content.length > 50
                  ? '${article.content.substring(0, 50)}...'
                  : article.content,
              style: const TextStyle(fontSize: 12, color: Color(0xFF666666)),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Image
          Expanded(
            flex: 2,
            child: article.imageUrl != null
                ? Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(article.imageUrl!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0E0E0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.image,
                      size: 20,
                      color: Color(0xFF999999),
                    ),
                  ),
          ),

          // Actions
          Expanded(
            flex: 2,
            child: Row(
              children: [
                IconButton(
                  onPressed: () => onEdit(article),
                  icon: const Icon(Icons.edit),
                  color: const Color(0xFFFF9800),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => onDelete(article),
                  icon: const Icon(Icons.delete),
                  color: const Color(0xFFF44336),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
