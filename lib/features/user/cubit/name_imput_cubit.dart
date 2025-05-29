// lib/cubit/user_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserCubit extends Cubit<String> {
  static const _keyUsername = 'username';

  UserCubit() : super('') {
    loadUsername();
  }

  Future<void> loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString(_keyUsername) ?? '';
    emit(username);
  }

  Future<void> setUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUsername, username);
    emit(username);
  }
}
