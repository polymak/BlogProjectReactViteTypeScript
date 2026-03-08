import 'package:flutter/material.dart';
import 'package:blog_project/widgets/admin_user_row.dart';
import 'package:blog_project/models/admin.dart';

class AdminUsersTableCard extends StatelessWidget {
  final List<Admin> users;
  final ValueChanged<Admin> onDeleteUser;
  final bool isLoading;

  const AdminUsersTableCard({
    Key? key,
    required this.users,
    required this.onDeleteUser,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section header
            const Text(
              'Liste des utilisateurs',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),

            const SizedBox(height: 16),

            // Table header
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1),
                ),
              ),
              child: Row(
                children: const [
                  SizedBox(width: 52), // Avatar space
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF999999),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Nom utilisateur',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF999999),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Rôle',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF999999),
                      ),
                    ),
                  ),
                  SizedBox(width: 60), // Action button space
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Users list
            isLoading
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator(
                        color: Color(0xFF1976D2),
                      ),
                    ),
                  )
                : users.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Aucun utilisateur pour le moment',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF999999),
                        ),
                      ),
                    ),
                  )
                : Column(
                    children: users.map((user) {
                      return AdminUserRow(
                        username: user.username,
                        email: user.email,
                        role: user.role,
                        createdAt: user.createdAt ?? DateTime.now(),
                        onDelete: () => onDeleteUser(user),
                        isLoading: isLoading,
                      );
                    }).toList(),
                  ),
          ],
        ),
      ),
    );
  }
}
