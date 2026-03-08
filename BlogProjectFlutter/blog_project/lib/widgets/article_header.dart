import 'package:flutter/material.dart';

class ArticleHeader extends StatelessWidget {
  final String? imageUrl;
  final String title;

  const ArticleHeader({Key? key, this.imageUrl, required this.title})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image header
        if (imageUrl != null)
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              imageUrl!,
              height: 240,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 240,
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: const Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: 48,
                      color: Colors.grey,
                    ),
                  ),
                );
              },
            ),
          ),

        // Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
              height: 1.3,
              letterSpacing: 0.3,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
