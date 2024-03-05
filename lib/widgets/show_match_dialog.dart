import 'package:flutter/material.dart';
import 'package:tfg_redesign/models/match.dart';

class ShowMatchInfo extends StatelessWidget {
  final Match match;

  const ShowMatchInfo({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return matchForm(context);
  }

  AlertDialog matchForm(BuildContext context) {
    return AlertDialog(
      title: const Text("Partida"),
      content: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(match.id.toString()),
            Text(match.duration.toString()),
            Text(match.hits.toString()),
            Text(match.errors.toString()),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Volver"),
        ),
      ],
    );
  }
}
