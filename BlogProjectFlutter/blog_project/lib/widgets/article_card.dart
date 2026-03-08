import 'package:flutter/material.dart';

class ArticleCard extends StatelessWidget {
  final String category;
  final String time;
  final String title;
  final String summary;
  final String author;
  final String imageUrl;
  final VoidCallback onTap;

  const ArticleCard({
    Key? key,
    required this.category,
    required this.time,
    required this.title,
    required this.summary,
    required this.author,
    required this.imageUrl,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.network(
                imageUrl,
                height: 200,
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
                    height: 200,
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

            // Content section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category and time
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3F2FD),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          category,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1976D2),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF666666),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Title
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 8),

                  // Summary
                  Text(
                    summary,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      height: 1.5,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 16),

                  // Author and action
                  Row(
                    children: [
                      // Author avatar and name
                      Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE3F2FD),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Center(
                              child: Text(
                                'A',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1976D2),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            author,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF333333),
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),

                      // Read more button
                      Row(
                        children: [
                          Text(
                            'Lire la suite',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1976D2),
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.arrow_forward,
                            size: 16,
                            color: Color(0xFF1976D2),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
