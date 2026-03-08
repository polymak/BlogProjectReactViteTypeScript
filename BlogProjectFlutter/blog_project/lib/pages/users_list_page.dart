import 'package:flutter/material.dart';
import 'package:blog_project/services/api_service.dart';
import 'package:blog_project/models/admin.dart';
import 'package:blog_project/widgets/admin_users_header.dart';
import 'package:blog_project/widgets/add_admin_user_card.dart';
import 'package:blog_project/widgets/admin_users_table_card.dart';
import 'package:blog_project/widgets/admin_bottom_nav.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({Key? key}) : super(key: key);

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  final ApiService _apiService = ApiService();
  List<Admin> _admins = [];
  bool _isLoading = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadAdmins();
  }

  Future<void> _loadAdmins() async {
    setState(() {
      _isLoading = true;
    });

    final admins = await _apiService.getAdmins();
    setState(() {
      _admins = admins;
      _isLoading = false;
    });
  }

  Future<void> _createAdmin() async {
    if (_usernameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez remplir tous les champs'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final admin = await _apiService.createAdmin(
      _usernameController.text,
      _emailController.text,
      _passwordController.text,
      _roleController.text.isNotEmpty ? _roleController.text : 'admin',
    );

    if (admin != null) {
      _usernameController.clear();
      _emailController.clear();
      _passwordController.clear();
      _roleController.clear();
      await _loadAdmins();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Utilisateur créé avec succès'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erreur lors de la création de l\'utilisateur'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _deleteAdmin(Admin admin) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmer la suppression'),
        content: const Text(
          'Êtes-vous sûr de vouloir supprimer cet utilisateur ?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final success = await _apiService.deleteAdmin(admin.id);
      if (success) {
        await _loadAdmins();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Utilisateur supprimé avec succès'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erreur lors de la suppression'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            AdminUsersHeader(
              onMenuTap: () {
                // Handle menu tap
              },
            ),

            const SizedBox(height: 16),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                'Liste des utilisateurs admin',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Add user card
            AddAdminUserCard(
              usernameController: _usernameController,
              emailController: _emailController,
              passwordController: _passwordController,
              roleController: _roleController,
              selectedRole: 'admin',
              onRoleChanged: (value) {
                // Handle role change
              },
              onAddUser: _createAdmin,
              isLoading: false,
            ),

            const SizedBox(height: 16),

            // Users table
            AdminUsersTableCard(
              users: _admins,
              onDeleteUser: _deleteAdmin,
              isLoading: _isLoading,
            ),

            const SizedBox(height: 8),

            // Bottom navigation
            AdminBottomNav(
              currentIndex: 1, // Users tab
              onTap: (index) {
                // Handle navigation
                switch (index) {
                  case 0:
                    Navigator.pushNamed(context, '/dashboard');
                    break;
                  case 1:
                    // Already on users page
                    break;
                  case 2:
                    Navigator.pushNamed(context, '/dashboard/blogs');
                    break;
                  case 3:
                    // Handle settings
                    break;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
