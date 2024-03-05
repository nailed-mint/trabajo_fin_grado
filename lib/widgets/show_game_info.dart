import 'package:flutter/material.dart';
import 'package:tfg_redesign/models/game.dart';
import 'package:tfg_redesign/screens/game_board.dart';
import 'package:tfg_redesign/screens/std_board.dart';
import 'package:tfg_redesign/services/arasaac_service.dart';

class ShowGameInfo extends StatefulWidget {
  final Game game;

  const ShowGameInfo({super.key, required this.game});

  @override
  State<ShowGameInfo> createState() => _ShowGameInfoState();
}

class _ShowGameInfoState extends State<ShowGameInfo> {
  @override
  Widget build(BuildContext context) {
    return gameForm(context);
  }

  AlertDialog gameForm(BuildContext context) {
    return AlertDialog(
      title: Text(widget.game.name),
      content: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ArasaacService.getPictogram(icon: widget.game.icon),
            Text(widget.game.description),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => chooseGame(context),
          child: const Text("Jugar"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Volver"),
        ),
      ],
    );
  }

  Future<dynamic> chooseGame(BuildContext context) {
    switch (widget.game.id) {
      case 1:
        return Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SpotTheDifferenceBoard(),
          ),
        );
      default:
        return Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const GameBoard()),
        );
    }
  }
}
