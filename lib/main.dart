import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trabajo_fin_grado/Model/user_model.dart';
import 'package:trabajo_fin_grado/View/menu/choose_profile_menu.dart';
import 'package:trabajo_fin_grado/View/menu/profile_menu.dart';
import 'package:trabajo_fin_grado/session.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => Session<User>(),
    child: const MainApp(),
  ));
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
      home: const ChooseProfileMenu(),
      // home: const ProfileMenu(),
    );
  }
}
