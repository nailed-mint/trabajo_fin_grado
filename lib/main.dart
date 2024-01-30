import 'package:flutter/material.dart';
import 'package:trabajo_fin_grado/View/menu/menu.dart';

/// The main entry point of the application.
void main() {
  /// Starting the application with the MainApp widget.
  runApp(const MainApp());
}

/// The main application widget that provides the app state to its children.
class MainApp extends StatelessWidget {
  /// Constructor for the MainApp widget.
  const MainApp({super.key});

  /// Builds the MainApp widget.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /// The title of the application.
      title: "TFG", // Provisional name
      /// The theme of the application.
      theme: ThemeData(
        useMaterial3: true,

        /// The color scheme of the application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),

      /// The home page of the application.
      home: const Scaffold(
        body: MenuPage(),
      ),
    );
  }
}
