import 'dart:math';

import 'package:flutter/material.dart';

import 'package:trabajo_fin_grado/Controller/shared.dart';
import 'package:trabajo_fin_grado/View/games/spot_the_difference/widgets/invisible_button.dart'; // DEBUG
import 'package:trabajo_fin_grado/View/games/widgets/score_display.dart';

String path = 'assets/games_levels/spot_the_difference.json';

/// Clase que genera la pantalla del juego
Widget spotTheDifference({
  required BuildContext context,
  required ScoreDisplayState? scoreDisplayState,
}) {
  late Map<String, dynamic> config;
  late dynamic randomLevel;

  // STEP 1: READ CONFIG FILE
  loadJson(path: path).then((value) {
    config = value;
    List levels = config["levels"] as List;

    // STEP 2: CHOOSE RANDOM LEVEL
    var random = Random();
    var randomIndex = random.nextInt(levels.length);

    randomLevel = levels[randomIndex];
  });

  // STEP 3: ESTABLISH FINAL SCORE
  scoreDisplayState!.setFinalScore(randomLevel["differences"].length);

  // STEP 4: CREATE DIFFERENCE WIDGET
  String pathImageA = randomLevel["pathImageA"];
  String pathImageB = randomLevel["pathImageB"];

  List<Widget> childWithoutButtons = [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => Dialog(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// The title of the dialog.
                    const Text(
                      "Aquí no",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),

                    /// The body of the dialog.
                    const Text(
                      "Hay que pulsar la imagen de arriba",
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 16),

                    /// An ElevatedButton that can be used to close the dialog or perform another action.
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Volver al juego"),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        child: Image.asset(
          pathImageB,
          width: MediaQuery.of(context).size.width * 0.6,
          fit: BoxFit.cover,
        ),
      ),
    ),
  ];

  List<Widget> childWithButtons = [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: scoreDisplayState.increaseErrors,
        child: Image.asset(
          pathImageA,
          width: MediaQuery.of(context).size.width * 0.6,
          fit: BoxFit.cover,
        ),
      ),
    )
  ];

  List<Positioned> differenceButtons = List.generate(
    randomLevel["differences"].length,
    (index) => Positioned(
      top: randomLevel["differences"]["top"].toDouble(),
      left: randomLevel["differences"]["left"].toDouble(),
      child: InvisibleButton(
        onButtonPressed: scoreDisplayState.increaseScore,
      ),
    ),
  );

  return Center(
    child: Column(
      children: [
        Stack(children: childWithButtons + differenceButtons),
        Stack(children: childWithoutButtons),
      ],
    ),
  );
}
