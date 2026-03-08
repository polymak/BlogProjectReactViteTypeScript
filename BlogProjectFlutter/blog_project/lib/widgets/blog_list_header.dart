import 'package:flutter/material.dart';

class BlogListHeader extends StatelessWidget {
  const BlogListHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title section
          Text(
            'Liste des blogs',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1A202C),
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Gérez vos articles et publications',
            style: TextStyle(
              fontSize: 14,
              color: const Color(0xFF666666),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
