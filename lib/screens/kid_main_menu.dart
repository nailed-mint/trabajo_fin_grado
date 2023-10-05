import 'package:flutter/material.dart';
import 'package:trabajo_fin_grado/screens/choose_game_menu.dart';
import 'package:trabajo_fin_grado/widgets/navigable_image.dart';

import '../main.dart';

class KidMainMenu extends StatelessWidget {
  const KidMainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: const Text("¿Qué quieres hacer?")),),
      body: Center(
        child: NavigableImage(clickDestination: ChooseGameMenu(),),
      ),
    );
  }
}