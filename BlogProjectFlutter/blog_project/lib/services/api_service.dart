import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:blog_project/models/admin.dart';
import 'package:blog_project/models/post.dart';

class ApiService {
  static const String baseUrl = 'https://blog-backend-kf3i.onrender.com/api';
  static const String baseUploadUrl = 'https://blog-backend-kf3i.onrender.com';

  final http.Client client = http.Client();

  Future<Map<String, dynamic>?> login(String username, String password) async {
    try {
      final trimmedUsername = username.trim();
      final trimmedPassword = password.trim();

      print('Attempting login with username: $trimmedUsername');

      final response = await client.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': trimmedUsername,
          'password': trimmedPassword,
        }),
      );

      print('Login response status: ${response.statusCode}');
      print('Login response body: ${response.body}');

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        print('Login successful, result: $result');
        return result;
      } else {
        print('Login failed with status: ${response.statusCode}');
        print('Response: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }

  Future<List<Post>> getPosts() async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/posts'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => Post.fromJson(item)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Get posts error: $e');
      return [];
    }
  }

  Future<Post?> getPost(int id) async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/posts/$id'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Post.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      print('Get post error: $e');
      return null;
    }
  }

  Future<Post?> createPost(
    String title,
    String content,
    String? imageUrl,
  ) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/posts'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'title': title,
          'content': content,
          'image_url': imageUrl,
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return Post.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      print('Create post error: $e');
      return null;
    }
  }

  Future<Post?> updatePost(
    int id,
    String title,
    String content,
    String? imageUrl,
  ) async {
    try {
      final response = await client.put(
        Uri.parse('$baseUrl/posts/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'title': title,
          'content': content,
          'image_url': imageUrl,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Post.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      print('Update post error: $e');
      return null;
    }
  }

  Future<bool> deletePost(int id) async {
    try {
      final response = await client.delete(Uri.parse('$baseUrl/posts/$id'));

      return response.statusCode == 200;
    } catch (e) {
      print('Delete post error: $e');
      return false;
    }
  }

  Future<List<Admin>> getAdmins() async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/admins'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => Admin.fromJson(item)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Get admins error: $e');
      return [];
    }
  }

  Future<Admin?> createAdmin(
    String username,
    String email,
    String password,
    String role,
  ) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/admins'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
          'role': role,
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return Admin.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      print('Create admin error: $e');
      return null;
    }
  }

  Future<bool> deleteAdmin(int id) async {
    try {
      final response = await client.delete(Uri.parse('$baseUrl/admins/$id'));

      return response.statusCode == 200;
    } catch (e) {
      print('Delete admin error: $e');
      return false;
    }
  }
}
