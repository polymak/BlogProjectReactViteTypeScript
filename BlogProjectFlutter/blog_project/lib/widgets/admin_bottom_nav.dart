import 'package:flutter/material.dart';

class AdminBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AdminBottomNav({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE0E0E0), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Dashboard
          _buildNavItem(
            icon: Icons.dashboard,
            label: 'Dashboard',
            isActive: currentIndex == 0,
            onTap: () => onTap(0),
          ),

          // Users
          _buildNavItem(
            icon: Icons.group,
            label: 'Utilisateurs',
            isActive: currentIndex == 1,
            onTap: () => onTap(1),
          ),

          // Articles
          _buildNavItem(
            icon: Icons.article,
            label: 'Articles',
            isActive: currentIndex == 2,
            onTap: () => onTap(2),
          ),

          // Settings
          _buildNavItem(
            icon: Icons.settings,
            label: 'Paramètres',
            isActive: currentIndex == 3,
            onTap: () => onTap(3),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFF5F5F5) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: isActive
                  ? const Color(0xFF1976D2)
                  : const Color(0xFF999999),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: isActive
                    ? const Color(0xFF333333)
                    : const Color(0xFF999999),
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
