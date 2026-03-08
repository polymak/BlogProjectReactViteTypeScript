import 'package:flutter/material.dart';

class TagList extends StatelessWidget {
  final List<String> tags;

  const TagList({Key? key, required this.tags}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: tags.map((tag) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
            ),
            child: Text(
              tag,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF666666),
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
