import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const HalimTekApp());
}

class HalimTekApp extends StatelessWidget {
  const HalimTekApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HalimTek',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
