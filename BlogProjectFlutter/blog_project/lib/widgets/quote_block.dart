import 'package:flutter/material.dart';

class QuoteBlock extends StatelessWidget {
  final String quote;

  const QuoteBlock({Key? key, required this.quote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE3F2FD), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quote icon
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Icon(
                Icons.format_quote,
                size: 28,
                color: Color(0xFF1976D2),
              ),
            ),

            // Quote text
            Text(
              quote,
              style: const TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Color(0xFF333333),
                height: 1.6,
                letterSpacing: 0.2,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
