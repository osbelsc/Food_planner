// lib/features/user/providers/user_provider.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  String _username = '';

  String get username => _username;

  UserProvider() {
    loadUsername();
  }

  Future<void> loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    _username = prefs.getString('username') ?? '';
    notifyListeners();
  }

  Future<void> setUsername(String name) async {
    final prefs = await SharedPreferences.getInstance();
    _username = name;
    await prefs.setString('username', name);
    notifyListeners();
  }
}
