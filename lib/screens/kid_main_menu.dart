import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';

import 'package:trabajo_fin_grado/screens/choose_game_menu.dart';
import 'package:trabajo_fin_grado/screens/instructions_page.dart';
import 'package:trabajo_fin_grado/widgets/big_button.dart';
import 'package:trabajo_fin_grado/widgets/close_dialog.dart';

class KidMainMenu extends StatelessWidget {
  const KidMainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(children: [
          BigButton(
              buttonText: "Jugar",
              imageUrl: "/pictograms/29151",
              nextPage: ChooseGameMenu()),
          BigButton(
            buttonText: "Instrucciones",
            imageUrl: "/pictograms/34705",
            nextPage: InstructionsPage(),
          ),
          BigButton(
            buttonText: "Se acabó",
            imageUrl: "/pictograms/28429",
            nextPage: CloseDialog(),
          ),
        ]),
      ),
    );
  }
}
