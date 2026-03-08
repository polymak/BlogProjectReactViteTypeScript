import 'package:flutter/material.dart';

class DashboardIntro extends StatelessWidget {
  const DashboardIntro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Text(
            'Liste des blogs',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),

          const SizedBox(height: 4),

          // Subtitle
          const Text(
            'Gérez vos articles et publications',
            style: TextStyle(fontSize: 14, color: Color(0xFF666666)),
          ),
        ],
      ),
    );
  }
}
