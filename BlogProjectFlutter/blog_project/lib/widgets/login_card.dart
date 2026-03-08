import 'package:flutter/material.dart';
import 'package:blog_project/widgets/username_field.dart';
import 'package:blog_project/widgets/password_field.dart';
import 'package:blog_project/widgets/login_button.dart';

class LoginCard extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final String? usernameError;
  final String? passwordError;
  final bool obscureText;
  final VoidCallback onToggleObscureText;
  final VoidCallback onLogin;
  final bool isLoading;
  final ValueChanged<String>? onUsernameChanged;
  final ValueChanged<String>? onPasswordChanged;

  const LoginCard({
    Key? key,
    required this.usernameController,
    required this.passwordController,
    this.usernameError,
    this.passwordError,
    required this.obscureText,
    required this.onToggleObscureText,
    required this.onLogin,
    required this.isLoading,
    this.onUsernameChanged,
    this.onPasswordChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon circle
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(32),
              ),
              child: const Icon(
                Icons.shield,
                color: Color(0xFF1976D2),
                size: 32,
              ),
            ),

            const SizedBox(height: 16),

            // Title
            const Text(
              'Connexion Admin',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),

            const SizedBox(height: 8),

            // Subtitle
            const Text(
              'Connecte-toi pour gérer les articles et les utilisateurs.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF666666),
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),

            // Username field
            UsernameField(
              controller: usernameController,
              errorText: usernameError,
              onChanged: onUsernameChanged,
            ),

            const SizedBox(height: 20),

            // Password field
            PasswordField(
              controller: passwordController,
              errorText: passwordError,
              onChanged: onPasswordChanged,
              obscureText: obscureText,
              onToggleObscureText: onToggleObscureText,
            ),

            const SizedBox(height: 16),

            // Remember me checkbox
            Row(
              children: [
                Checkbox(
                  value: false, // Visual only - no backend functionality
                  onChanged: (value) {
                    // Visual only - no backend functionality
                  },
                  activeColor: const Color(0xFF1976D2),
                  side: const BorderSide(color: Color(0xFFCCCCCC), width: 1),
                ),
                const Text(
                  'Rester connecté',
                  style: TextStyle(fontSize: 14, color: Color(0xFF333333)),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Login button
            LoginButton(onPressed: onLogin, isLoading: isLoading),

            const SizedBox(height: 24),

            // Support line
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Problème d\'accès ?',
                  style: TextStyle(fontSize: 12, color: Color(0xFF666666)),
                ),
                const SizedBox(width: 4),
                TextButton(
                  onPressed: () {
                    // Visual only - no backend functionality
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Contacter le support',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF1976D2),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
