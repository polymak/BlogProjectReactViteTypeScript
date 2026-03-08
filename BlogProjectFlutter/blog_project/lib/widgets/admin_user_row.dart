import 'package:flutter/material.dart';

class AdminUserRow extends StatelessWidget {
  final String username;
  final String email;
  final String role;
  final DateTime createdAt;
  final VoidCallback onDelete;
  final bool isLoading;

  const AdminUserRow({
    Key? key,
    required this.username,
    required this.email,
    required this.role,
    required this.createdAt,
    required this.onDelete,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User info row
            Row(
              children: [
                // Avatar placeholder
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFE0E0E0),
                      width: 1,
                    ),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Color(0xFF1976D2),
                    size: 20,
                  ),
                ),

                const SizedBox(width: 12),

                // User details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF333333),
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        email,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF666666),
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Role badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3F2FD),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          role.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1976D2),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Action button
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Color(0xFFD32F2F),
                    size: 24,
                  ),
                  onPressed: isLoading ? null : onDelete,
                  tooltip: 'Supprimer',
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Created date
            Text(
              'Créé le ${createdAt.day}/${createdAt.month}/${createdAt.year}',
              style: const TextStyle(fontSize: 12, color: Color(0xFF999999)),
            ),
          ],
        ),
      ),
    );
  }
}
