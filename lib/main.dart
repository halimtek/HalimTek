import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize default admin account
  const adminEmail = 'admin@halimtek.com';
  const adminPassword = 'admin123';
  final users = await AuthService.getUsers();

  if (!users.any((u) => u.email == adminEmail)) {
    await AuthService.register(adminEmail, adminPassword, isAdmin: true);
    debugPrint('Admin account created: $adminEmail / $adminPassword');
  }

  runApp(const HalimTekApp());
}

class HalimTekApp extends StatelessWidget {
  const HalimTekApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HalimTek',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const AnimatedLoginScreen(),
    );
  }
}
