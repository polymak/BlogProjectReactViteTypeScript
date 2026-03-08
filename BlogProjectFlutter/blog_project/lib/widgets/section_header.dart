import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const SectionHeader({Key? key, required this.title, required this.subtitle})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 14, color: Color(0xFF666666)),
          ),
        ],
      ),
    );
  }
}
