import 'package:flutter/material.dart';
import 'package:trabajo_fin_grado/screens/choose_game_menu.dart';
import 'package:trabajo_fin_grado/widgets/navigable_image.dart';

class KidMainMenu extends StatelessWidget {
  const KidMainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("¿Qué quieres hacer?")),
        ),
        body: const SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Center(
              child: NavigableImage(
                clickDestination: ChooseGameMenu(),
                path: 'assets/images/jugar con el tablet.png',
                caption: 'Jugar',
              ),
            ),
            Center(
              child: NavigableImage(
                clickDestination: ChooseGameMenu(),
                path: 'assets/images/instrucciones.png',
                caption: 'Instrucciones de la aplicación',
              ),
            ),
            Center(
              child: NavigableImage(
                clickDestination: ChooseGameMenu(),
                path: 'assets/images/yo.png',
                caption: 'Salir',
              ),
            ),
          ],
        )));
  }
}
