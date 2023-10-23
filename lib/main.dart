import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trabajo_fin_grado/screens/home_page.dart';

/// The main entry point of the application.
void main() {
  runApp(const MaterialApp(
    title: "My app",
    home: SafeArea(child: MainApp()),
  ));
}

/// The main application widget that provides the app state to its children.
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainAppState(),
      child: MaterialApp(
        title: "TFG", // Provisional name
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        ),
        home: HomePage(),
      ),
    );
  }
}

/// The application state that holds variables and methods used throughout the app.
class MainAppState extends ChangeNotifier {
  // Put here variables that must be notified when changed and are useful for the whole app

  // Put here the necessary methods to work with those variablesimport 'package:provider/provider.dart';
}
