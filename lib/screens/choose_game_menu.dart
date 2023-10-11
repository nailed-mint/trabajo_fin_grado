import 'package:flutter/material.dart';

class ChooseGameMenu extends StatelessWidget {
  const ChooseGameMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menú de juegos"),
      ),
      body: const Center(
        child: Text("elige un juego"),
      ),
    );
  }
}
