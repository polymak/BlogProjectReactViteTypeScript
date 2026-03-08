import 'package:flutter/material.dart';

class AdminTopBar extends StatelessWidget {
  final VoidCallback onMenuTap;
  final VoidCallback onNotificationTap;
  final VoidCallback onAvatarTap;

  const AdminTopBar({
    Key? key,
    required this.onMenuTap,
    required this.onNotificationTap,
    required this.onAvatarTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1)),
      ),
      child: Row(
        children: [
          // Menu button
          IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFF333333), size: 24),
            onPressed: onMenuTap,
          ),

          const SizedBox(width: 8),

          // Title
          const Text(
            'Mon Blog Admin',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),

          const Spacer(),

          // Notification icon
          IconButton(
            icon: const Icon(
              Icons.notifications_outlined,
              color: Color(0xFF666666),
              size: 24,
            ),
            onPressed: onNotificationTap,
          ),

          // Avatar
          InkWell(
            onTap: onAvatarTap,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color(0xFFE0E0E0), width: 1),
              ),
              child: const Icon(
                Icons.person,
                color: Color(0xFF1976D2),
                size: 20,
              ),
            ),
          ),

          const SizedBox(width: 16),
        ],
      ),
    );
  }
}
