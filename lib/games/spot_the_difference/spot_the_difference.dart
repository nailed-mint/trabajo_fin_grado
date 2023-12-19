import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:trabajo_fin_grado/games/spot_the_difference/widgets/invisible_button.dart'; // DEBUG

/// Clase que genera la pantalla del juego
class SpotTheDifference extends StatefulWidget {
  const SpotTheDifference({super.key});

  @override
  SpotTheDifferenceState createState() => SpotTheDifferenceState();
}

class SpotTheDifferenceState extends State<SpotTheDifference> {
  final logger = Logger(); // DEBUG

  final player = AudioPlayer();
  Duration duration = const Duration();
  Timer? timer;
  int score = 0;
  int errors = 0;
  final finalScore = 6;
  int touchCount = 0;
  DateTime now = DateTime.now();
  DateTime currentBackPressTime = DateTime.now();

  void checkEndGame() {
    if (score == finalScore) {
      logger.d("score: $score\n errors: $errors");
    }
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          color: Colors.amber,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: score == finalScore
                  ? <Widget>[
                      const Text('¡Enhorabuena!'),
                      ElevatedButton(
                        child: const Text('Volver al menú'),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      ),
                    ]
                  : <Widget>[
                      const Text('Todavía te faltan diferencias por encontrar'),
                      ElevatedButton(
                        child: const Text('Seguir jugando'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
            ),
          ),
        );
      },
    );
    score == finalScore ? stopTimer() : null;
  }

  Future<void> increaseScore() async {
    setState(() {
      score += 1;
    });
    score == finalScore ? checkEndGame() : null;
    await player.play(
      AssetSource('audio/sfx/446111__justinvoke__success-jingle.wav'),
    );
  }

  void increaseErrors() {
    setState(() {
      errors += 1;
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void stopTimer() {
    timer?.cancel();
  }

  void addTime() {
    const addSeconds = 1;

    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      duration = Duration(seconds: seconds);
    });
  }

  void invokePop() {
    currentBackPressTime = DateTime.now();

    if (currentBackPressTime.difference(now) > const Duration(seconds: 2)) {
      // If more than 2 seconds have passed since last press, reset counter
      touchCount = 0;
    } else {
      touchCount++;
    }
    now = currentBackPressTime;
    touchCount >= 7 ? Navigator.pop(context) : null;
  }

  /// Este Widget se usa para abandonar el juego
  /// Para ello, debe pulsarse 5 veces seguidas
  /// Cada pulsación no debe tardar más de 2 segundos desde la anterior o,
  /// de lo contrario, el contador se reiniciará
  Widget exitButton() {
    return Card(
      margin: const EdgeInsets.all(8),
      child: TextButton(
        onPressed: invokePop,
        child: const Icon(Icons.arrow_back, size: 30),
      ),
    );
  }

  /// Este Widget se usa para mostrar la puntuación (el número de aciertos)
  Widget scoreDisplay() {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextButton(
          onPressed: checkEndGame,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.thumb_up),
              Text(
                "\t$score",
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Este Widget se usa para mostrar el tiempo transcurrido desde que se inició la partida
  Widget timeSpentCard() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final String minutes = duration.inMinutes.remainder(60).toString();
    final String seconds = twoDigits(duration.inSeconds.remainder(60));

    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.timer,
            ),
            Text(
              "\t$minutes:$seconds",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Crea una columna con las 2 imagenes similares
  /// La de arriba solo está de referencia
  /// En la de abajo hay que tocar las diferencias para que queden resaltadas
  Widget differencesImage(String pathImageA, String pathImageB) {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: increaseErrors,
                  child: Image.asset(
                    pathImageA,
                    width: MediaQuery.of(context).size.width * 0.6,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 90,
                left: 50,
                child: InvisibleButton(
                  onButtonPressed: increaseScore,
                ),
              ),
              Positioned(
                top: 80,
                left: 160,
                child: InvisibleButton(
                  onButtonPressed: increaseScore,
                ),
              ),
              Positioned(
                top: 55,
                left: 135,
                child: InvisibleButton(
                  onButtonPressed: increaseScore,
                ),
              ),
              Positioned(
                top: 20,
                left: 90,
                child: InvisibleButton(
                  onButtonPressed: increaseScore,
                ),
              ),
              Positioned(
                top: 45,
                left: 180,
                child: InvisibleButton(
                  onButtonPressed: increaseScore,
                ),
              ),
              Positioned(
                top: 170,
                left: 190,
                child: InvisibleButton(
                  onButtonPressed: increaseScore,
                ),
              ),
            ],
          ),
          Stack(
            children: [
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
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
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
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  @override
  void dispose() {
    super.dispose();

    stopTimer();
  }

  @override
  Widget build(BuildContext context) => PopScope(
        canPop: false,
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: exitButton()),
                  Expanded(child: scoreDisplay()),
                  Expanded(child: timeSpentCard()),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Card(
                      margin: EdgeInsets.all(8),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "¡Encuentra las # diferencias!",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              differencesImage(
                "assets/images/spot_the_difference/01a.jpg",
                "assets/images/spot_the_difference/01b.jpg",
              ),
            ],
          ),
        ),
      );
}
