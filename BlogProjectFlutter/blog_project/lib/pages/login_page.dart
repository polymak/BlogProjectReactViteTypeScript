import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blog_project/providers/auth_provider.dart';
import 'package:blog_project/widgets/login_header.dart';
import 'package:blog_project/widgets/login_card.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              // Header
              LoginHeader(
                onBackTap: () {
                  Navigator.pop(context);
                },
              ),

              const SizedBox(height: 40),

              // Login card
              LoginCard(
                usernameController: _usernameController,
                passwordController: _passwordController,
                obscureText: authProvider.obscureText,
                onToggleObscureText: () {
                  authProvider.toggleObscureText();
                },
                onLogin: () async {
                  final trimmedUsername = _usernameController.text.trim();
                  final trimmedPassword = _passwordController.text.trim();

                  if (trimmedUsername.isNotEmpty &&
                      trimmedPassword.isNotEmpty) {
                    final success = await authProvider.login(
                      trimmedUsername,
                      trimmedPassword,
                    );

                    if (success) {
                      print('Navigation to dashboard');
                      Navigator.pushReplacementNamed(context, '/dashboard');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Nom d\'utilisateur ou mot de passe incorrect',
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Veuillez remplir tous les champs'),
                        backgroundColor: Colors.orange,
                      ),
                    );
                  }
                },
                isLoading: authProvider.isLoading,
                onUsernameChanged: (value) {
                  // Optional: handle username changes
                },
                onPasswordChanged: (value) {
                  // Optional: handle password changes
                },
              ),

              const SizedBox(height: 32),

              // Footer
              const Text(
                '© 2024 Mon Blog Admin. Tous droits réservés.',
                style: TextStyle(fontSize: 12, color: Color(0xFF999999)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
