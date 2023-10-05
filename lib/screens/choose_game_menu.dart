import 'package:flutter/material.dart';
import 'package:trabajo_fin_grado/main.dart';
import 'package:trabajo_fin_grado/screens/kid_main_menu.dart';

import '../widgets/navigable_image.dart';

class ChooseGameMenu extends StatelessWidget {
  const ChooseGameMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: const Text("Menú de juegos")),),
      body: Center(
        child: const Center(child: const Text("elige un juego")),
      ),
    );
  }
}