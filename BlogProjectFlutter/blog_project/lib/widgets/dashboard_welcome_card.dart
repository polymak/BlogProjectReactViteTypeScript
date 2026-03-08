import 'package:flutter/material.dart';

class DashboardWelcomeCard extends StatelessWidget {
  final String? username;
  final int articleCount;
  final int viewCount;

  const DashboardWelcomeCard({
    Key? key,
    this.username,
    required this.articleCount,
    required this.viewCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Image placeholder
            Container(
              height: 160,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Icon(
                  Icons.dashboard,
                  size: 48,
                  color: Color(0xFF1976D2),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Icon circle
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(32),
              ),
              child: const Icon(
                Icons.dashboard,
                color: Color(0xFF1976D2),
                size: 32,
              ),
            ),

            const SizedBox(height: 16),

            // Title
            const Text(
              'Dashboard Admin',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),

            const SizedBox(height: 8),

            // Subtitle
            Text(
              'Bienvenue ${username ?? 'Admin'}, ravi de vous revoir.',
              style: const TextStyle(fontSize: 16, color: Color(0xFF666666)),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            // Statistics row
            Row(
              children: [
                // Articles card
                Expanded(
                  child: StatCard(
                    label: 'ARTICLES',
                    value: articleCount.toString(),
                    icon: Icons.article,
                  ),
                ),

                const SizedBox(width: 16),

                // Views card
                Expanded(
                  child: StatCard(
                    label: 'VUES',
                    value: viewCount.toString(),
                    icon: Icons.visibility,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Primary action button
            PrimaryActionButton(
              onPressed: () {
                // Navigate to statistics if route exists
                // Otherwise keep as visual element
              },
            ),
          ],
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const StatCard({
    Key? key,
    required this.label,
    required this.value,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Icon(icon, size: 24, color: const Color(0xFF1976D2)),

          const SizedBox(height: 8),

          // Label
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF999999),
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 4),

          // Value
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
        ],
      ),
    );
  }
}

class PrimaryActionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const PrimaryActionButton({Key? key, required this.onPressed})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1976D2),
          foregroundColor: Colors.white,
          elevation: 4,
          shadowColor: const Color(0x401976D2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Voir les statistiques'),
            SizedBox(width: 8),
            Icon(Icons.trending_up, size: 20),
          ],
        ),
      ),
    );
  }
}
