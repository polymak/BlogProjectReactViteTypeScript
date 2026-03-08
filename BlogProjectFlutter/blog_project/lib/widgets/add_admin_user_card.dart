import 'package:flutter/material.dart';
import 'package:blog_project/widgets/admin_user_form.dart';

class AddAdminUserCard extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController roleController;
  final String? selectedRole;
  final ValueChanged<String?>? onRoleChanged;
  final VoidCallback onAddUser;
  final bool isLoading;

  const AddAdminUserCard({
    Key? key,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.roleController,
    this.selectedRole,
    this.onRoleChanged,
    required this.onAddUser,
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
        child: AdminUserForm(
          usernameController: usernameController,
          emailController: emailController,
          passwordController: passwordController,
          roleController: roleController,
          selectedRole: selectedRole,
          onRoleChanged: onRoleChanged,
          onAddUser: onAddUser,
          isLoading: isLoading,
        ),
      ),
    );
  }
}
