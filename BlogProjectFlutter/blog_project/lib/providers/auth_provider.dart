import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:blog_project/models/admin.dart';
import 'package:blog_project/services/api_service.dart';

class AuthProvider with ChangeNotifier {
  Admin? _currentUser;
  bool _isLoading = false;
  bool _obscureText = true;
  final ApiService _apiService = ApiService();

  Admin? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get obscureText => _obscureText;

  AuthProvider() {
    _loadUserFromStorage();
  }

  Future<void> _loadUserFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userData = prefs.getString('admin');
      final token = prefs.getString('token');

      if (userData != null && token != null) {
        final Map<String, dynamic> userMap = jsonDecode(userData);
        _currentUser = Admin.fromJson(userMap);
        notifyListeners();
      }
    } catch (e) {
      print('Error loading user from storage: $e');
    }
  }

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await _apiService.login(username, password);

      if (result != null &&
          result is Map<String, dynamic> &&
          result['admin'] != null &&
          result['token'] != null &&
          result['token'] is String &&
          result['token'].isNotEmpty) {
        final prefs = await SharedPreferences.getInstance();
        final adminData = result['admin'];
        final token = result['token'];

        if (adminData is Map<String, dynamic>) {
          _currentUser = Admin.fromJson(adminData);
          await prefs.setString('admin', jsonEncode(adminData));
          await prefs.setString('token', token);

          print('Login successful: user stored in SharedPreferences');
          _isLoading = false;
          notifyListeners();
          return true;
        } else {
          print('Login failed: invalid admin data format');
        }
      } else {
        print('Login failed: invalid response or missing token');
      }
    } catch (e) {
      print('Login exception: $e');
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('admin');
    await prefs.remove('token');
    _currentUser = null;
    notifyListeners();
  }

  String? getToken() {
    // In a real app, you would retrieve this from secure storage
    return null;
  }

  void toggleObscureText() {
    _obscureText = !_obscureText;
    notifyListeners();
  }
}
