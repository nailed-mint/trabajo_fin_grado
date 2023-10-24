import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';

class ChooseGameMenu extends StatelessWidget {
  const ChooseGameMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Elige un juego"),
      ),
      body: const Center(
        child: Text("elige un juego"),
      ),
    );
  }
}
