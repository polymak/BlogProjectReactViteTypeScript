import 'package:flutter/material.dart';

class AdminUserForm extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController roleController;
  final String? selectedRole;
  final ValueChanged<String?>? onRoleChanged;
  final VoidCallback onAddUser;
  final bool isLoading;

  const AdminUserForm({
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Row(
          children: [
            const Icon(Icons.person_add, color: Color(0xFF1976D2), size: 24),
            const SizedBox(width: 12),
            const Text(
              'Ajouter nouveau utilisateur',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Username field
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nom utilisateur',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                hintText: 'Entrez le nom',
                hintStyle: const TextStyle(
                  color: Color(0xFFCCCCCC),
                  fontSize: 16,
                ),
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF1976D2),
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
              style: const TextStyle(fontSize: 16, color: Color(0xFF333333)),
              cursorColor: const Color(0xFF1976D2),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Email field
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Email',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'exemple@mail.com',
                hintStyle: const TextStyle(
                  color: Color(0xFFCCCCCC),
                  fontSize: 16,
                ),
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF1976D2),
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
              style: const TextStyle(fontSize: 16, color: Color(0xFF333333)),
              cursorColor: const Color(0xFF1976D2),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Password field
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mot de passe',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: '••••••••',
                hintStyle: const TextStyle(
                  color: Color(0xFFCCCCCC),
                  fontSize: 16,
                ),
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF1976D2),
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
              style: const TextStyle(fontSize: 16, color: Color(0xFF333333)),
              cursorColor: const Color(0xFF1976D2),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Role field
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rôle',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedRole,
              onChanged: onRoleChanged,
              items: const [
                DropdownMenuItem(value: 'admin', child: Text('admin')),
                DropdownMenuItem(value: 'user', child: Text('user')),
              ],
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF1976D2),
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
              style: const TextStyle(fontSize: 16, color: Color(0xFF333333)),
              dropdownColor: Colors.white,
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Add button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isLoading ? null : onAddUser,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1976D2),
              foregroundColor: Colors.white,
              elevation: 4,
              shadowColor: const Color(0x401976D2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.save, size: 20),
                      SizedBox(width: 8),
                      Text('Ajouter nouveau utilisateur'),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
