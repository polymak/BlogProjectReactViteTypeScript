import 'package:flutter/material.dart';

class ArticleBody extends StatelessWidget {
  final String content;

  const ArticleBody({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Text(
        content,
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFF333333),
          height: 1.7,
          letterSpacing: 0.2,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
