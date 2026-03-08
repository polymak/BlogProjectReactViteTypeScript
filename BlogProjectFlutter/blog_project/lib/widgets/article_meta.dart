import 'package:flutter/material.dart';

class ArticleMeta extends StatelessWidget {
  final String? author;
  final DateTime? date;
  final String? readingTime;

  const ArticleMeta({Key? key, this.author, this.date, this.readingTime})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Author avatar and name
          if (author != null)
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Center(
                    child: Text(
                      'A',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1976D2),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  author!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF333333),
                  ),
                ),
              ],
            ),

          const Spacer(),

          // Date and reading time
          if (date != null || readingTime != null)
            Row(
              children: [
                if (date != null)
                  Text(
                    _formatDate(date!),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                    ),
                  ),
                if (date != null && readingTime != null)
                  const SizedBox(width: 8),
                if (readingTime != null)
                  Row(
                    children: [
                      const Icon(
                        Icons.schedule,
                        size: 16,
                        color: Color(0xFF666666),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        readingTime!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF666666),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
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
}
