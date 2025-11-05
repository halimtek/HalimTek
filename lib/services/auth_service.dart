import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthService {
  static const String usersKey = 'users';
  static const String currentUserKey = 'currentUser';

  static Future<List<User>> getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getStringList(usersKey) ?? [];
    return usersJson.map((e) => User.fromMap(jsonDecode(e))).toList();
  }

  static Future<void> saveUsers(List<User> users) async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = users.map((e) => jsonEncode(e.toMap())).toList();
    await prefs.setStringList(usersKey, usersJson);
  }

  static Future<bool> register(String email, String password,
      {bool isAdmin = false}) async {
    final users = await getUsers();
    if (users.any((u) => u.email == email)) return false; // already exists
    users.add(User(email: email, password: password, isAdmin: isAdmin));
    await saveUsers(users);
    return true;
  }

  static Future<User?> login(String email, String password) async {
    final users = await getUsers();
    final user =
        users.firstWhere((u) => u.email == email && u.password == password,
            orElse: () => null as User);
    if (user != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(currentUserKey, jsonEncode(user.toMap()));
    }
    return user;
  }

  static Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(currentUserKey);
    if (userJson == null) return null;
    return User.fromMap(jsonDecode(userJson));
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(currentUserKey);
  }
}
