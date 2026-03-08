import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:blog_project/models/admin.dart';
import 'package:blog_project/services/api_service.dart';

class AuthProvider with ChangeNotifier {
  Admin? _currentUser;
  bool _isLoading = false;
  final ApiService _apiService = ApiService();

  Admin? get currentUser => _currentUser;
  bool get isLoading => _isLoading;

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

      if (result != null) {
        final prefs = await SharedPreferences.getInstance();
        final adminData = result['admin'];
        final token = result['token'];

        _currentUser = Admin.fromJson(adminData);
        await prefs.setString('admin', jsonEncode(adminData));
        await prefs.setString('token', token);

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
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
}
