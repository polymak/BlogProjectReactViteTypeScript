import 'package:flutter/material.dart';

class MenuHeader extends StatelessWidget {
  final VoidCallback onClose;

  const MenuHeader({Key? key, required this.onClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          // Logo circle
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF1976D2),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(Icons.newspaper, color: Colors.white, size: 28),
          ),

          const SizedBox(width: 16),

          // Title
          Expanded(
            child: Text(
              'Mon Blog',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
          ),

          // Close button
          IconButton(
            icon: const Icon(Icons.close, size: 28, color: Color(0xFF1976D2)),
            onPressed: onClose,
          ),
        ],
      ),
    );
  }
}
