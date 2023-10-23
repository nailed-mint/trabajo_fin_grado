import 'package:flutter/material.dart';
import 'package:trabajo_fin_grado/screens/choose_game_menu.dart';

import 'package:trabajo_fin_grado/widgets/big_button.dart';
import 'package:trabajo_fin_grado/widgets/close_dialog.dart';

class KidMainMenu extends StatelessWidget {
  const KidMainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    // var homeState = context.watch<HomePage>();

    return Center(
      child: Column(children: [
        const BigButton(
            buttonText: "Jugar",
            imagePath: "assets/images/jugar con el tablet.png",
            nextPage: ChooseGameMenu()),
        BigButton(
          buttonText: "Instrucciones",
          imagePath: "assets/images/instrucciones.png",
          nextPage: InstructionsPage(),
        ),
        const BigButton(
          buttonText: "Cerrar",
          imagePath: "assets/images/cerrar.png",
          nextPage: CloseDialog(),
        ),
      ]),
    );
  }
}
