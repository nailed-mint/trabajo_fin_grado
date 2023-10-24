import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:trabajo_fin_grado/game.dart';
import 'package:trabajo_fin_grado/screens/home_page.dart';

/// The main entry point of the application.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setPortrait();
  FlameAudio.bgm.initialize();
  runApp(MainApp());
}

/// The main application widget that provides the app state to its children.
class MainApp extends StatelessWidget {
  final MyGame game = MyGame();

  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TFG", // Provisional name
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}
