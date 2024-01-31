import 'package:flutter/material.dart';
import 'package:trabajo_fin_grado/View/menu/profile_menu.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TFG", // Provisional name
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: const ProfileMenu(),
    );
  }
}
