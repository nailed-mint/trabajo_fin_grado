import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/game/widget/game_widget.dart';

import '../game.dart';
import 'package:trabajo_fin_grado/screens/kid_main_menu.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState() extends State<HomePage> {
  final MyGame game = MyGame();
  var roleSelected = "kid";

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch(roleSelected) {
      case "kid":
        page = const KidMainMenu();
        break;
      case "family":
        // page = FamilyMainMenu();
        // break;
      case "professional":
        // page = ProfessionalMainMenu();
        // break;
      default:
        throw UnimplementedError("no widget for $roleSelected");
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: GameWidget<MyGame>(game: game,),
      );
    });
  }
}
