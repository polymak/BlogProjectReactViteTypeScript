import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blog_project/providers/auth_provider.dart';
import 'package:blog_project/pages/login_page.dart';
import 'package:blog_project/pages/dashboard_page.dart';
import 'package:blog_project/pages/home_page.dart';
import 'package:blog_project/pages/post_details_page.dart';
import 'package:blog_project/pages/blog_list_page.dart';
import 'package:blog_project/pages/users_list_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog Project',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/dashboard/blogs': (context) => const BlogListPage(),
        '/dashboard/users': (context) => const UsersListPage(),
        '/posts/:id': (context) => const PostDetailsPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name?.startsWith('/posts/') == true) {
          final id = int.parse(settings.name!.split('/').last);
          return MaterialPageRoute(
            builder: (context) => PostDetailsPage(postId: id),
          );
        }
        return null;
      },
    );
  }
}
