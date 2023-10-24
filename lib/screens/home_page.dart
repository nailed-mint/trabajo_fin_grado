import 'package:flutter/material.dart';
import 'package:trabajo_fin_grado/widgets/big_button.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';

import '../game.dart';
import 'package:trabajo_fin_grado/screens/kid_main_menu.dart';

class HomePage extends StatelessWidget {
  final MyGame game = MyGame();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          BigButton(
              buttonText: "Niño",
              imageUrl: "/pictograms/31807",
              nextPage: KidMainMenu()),
          BigButton(
            buttonText: "Familia",
            imageUrl: "/pictograms/35060",
            nextPage: KidMainMenu(),
          ),
          BigButton(
            buttonText: "Profesional",
            imageUrl: "/pictograms/36950",
            nextPage: KidMainMenu(),
          ),
        ],
      ),
    );
  }
}
