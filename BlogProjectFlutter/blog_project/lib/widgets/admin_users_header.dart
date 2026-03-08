import 'package:flutter/material.dart';

class AdminUsersHeader extends StatelessWidget {
  final VoidCallback onMenuTap;

  const AdminUsersHeader({Key? key, required this.onMenuTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: const BoxDecoration(
        color: Color(0xFF1976D2),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          // Menu button
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white, size: 24),
            onPressed: onMenuTap,
          ),

          const SizedBox(width: 8),

          // Title
          const Text(
            'Mon Blog Admin',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const Spacer(),

          // Shield icon
          const Icon(Icons.shield, color: Color(0xFFE3F2FD), size: 28),

          const SizedBox(width: 16),
        ],
      ),
    );
  }
}
