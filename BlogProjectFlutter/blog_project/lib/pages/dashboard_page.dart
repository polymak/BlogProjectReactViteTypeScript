import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blog_project/providers/auth_provider.dart';
import 'package:blog_project/pages/blog_list_page.dart';
import 'package:blog_project/pages/users_list_page.dart';
import 'package:blog_project/widgets/admin_top_bar.dart';
import 'package:blog_project/widgets/dashboard_welcome_card.dart';
import 'package:blog_project/widgets/quick_navigation_section.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              // Top bar
              AdminTopBar(
                onMenuTap: () {
                  // Handle menu tap
                },
                onNotificationTap: () {
                  // Handle notification tap
                },
                onAvatarTap: () {
                  // Handle avatar tap
                },
              ),

              // Welcome card
              DashboardWelcomeCard(
                username: authProvider.currentUser?.username,
                articleCount: 12, // Placeholder - use real data if available
                viewCount: 1540, // Placeholder - use real data if available
              ),

              // Quick navigation
              QuickNavigationSection(
                onHomeTap: () {
                  // Navigate to home dashboard
                },
                onBlogsTap: () {
                  Navigator.pushNamed(context, '/dashboard/blogs');
                },
                onUsersTap: () {
                  Navigator.pushNamed(context, '/dashboard/users');
                },
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
