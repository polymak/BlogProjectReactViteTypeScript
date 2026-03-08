import 'package:flutter/material.dart';

class QuickNavigationSection extends StatelessWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onBlogsTap;
  final VoidCallback onUsersTap;

  const QuickNavigationSection({
    Key? key,
    required this.onHomeTap,
    required this.onBlogsTap,
    required this.onUsersTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          const Padding(
            padding: EdgeInsets.only(left: 4),
            child: Text(
              'NAVIGATION RAPIDE',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
                letterSpacing: 1.5,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Navigation items
          Column(
            children: [
              QuickNavItem(
                icon: Icons.home,
                title: 'Accueil dashboard',
                subtitle: 'Vue d\'ensemble de l\'activité',
                onTap: onHomeTap,
              ),

              const SizedBox(height: 12),

              QuickNavItem(
                icon: Icons.article,
                title: 'Liste des blogs',
                subtitle: 'Gérer vos publications',
                onTap: onBlogsTap,
              ),

              const SizedBox(height: 12),

              QuickNavItem(
                icon: Icons.people,
                title: 'Liste des utilisateurs',
                subtitle: 'Membres et permissions',
                onTap: onUsersTap,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class QuickNavItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const QuickNavItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon container
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 20, color: const Color(0xFF1976D2)),
            ),

            const SizedBox(width: 16),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF333333),
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF666666),
                    ),
                  ),
                ],
              ),
            ),

            // Arrow
            Icon(Icons.chevron_right, size: 24, color: const Color(0xFFCCCCCC)),
          ],
        ),
      ),
    );
  }
}
