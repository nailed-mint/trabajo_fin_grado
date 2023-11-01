import 'package:flutter/material.dart';
import 'package:trabajo_fin_grado/screens/menu.dart';

/// The main entry point of the application.
void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

/// The main application widget that provides the app state to its children.
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TFG", // Provisional name
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const Scaffold(
        body: MenuPage(),
      ),
    );
  }
}
