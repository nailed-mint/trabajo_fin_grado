import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trabajo_fin_grado/models/match.dart';

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
            Text("id: ${match.id.toString()}"),
            Text("gameId: ${match.gameId.toString()}"),
            Text(
              "createdOn: ${DateFormat('dd-MM-yyy').format(match.createdOn!)}",
            ),
            Text("duration: ${match.duration.toString()}"),
            Text("hits: ${match.hits.toString()}"),
            Text("errors: ${match.errors.toString()}"),
            Text("reportId: ${match.reportId.toString()}"),
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
