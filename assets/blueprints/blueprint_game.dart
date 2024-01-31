import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  GameState createState() => GameState();
}

class GameState extends State<Game> {
  // Exit button attributes
  int touchCount = 0;
  DateTime now = DateTime.now();
  DateTime currentBackPressTime = DateTime.now();
  // Score button attributes
  final player = AudioPlayer();
  int score = 0;
  int errors = 0;
  late int finalScore = 999999; // Must be changed to fit game level needs
  // Time Card attributes
  Duration duration = const Duration();
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    final String minutes = twoDigits(duration.inMinutes.remainder(60));
    final String seconds = twoDigits(duration.inSeconds.remainder(60));

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Exit button
                  Card(
                    margin: const EdgeInsets.all(8),
                    child: TextButton(
                      onPressed: invokePop,
                      child: const Icon(Icons.arrow_back, size: 30),
                    ),
                  ),
                  // Score button
                  Card(
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
                  ),
                  // Time spent card
                  Card(
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
                  ),
                ],
              ),
              // Game container goes here
              const Expanded(
                child: Text("Game container goes here"),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Exit button methods =======================================================
  void invokePop() {
    setState(() {
      currentBackPressTime = DateTime.now();

      if (currentBackPressTime.difference(now) > const Duration(seconds: 2)) {
        // If more than 2 seconds have passed since last press, reset counter
        touchCount = 0;
      } else {
        touchCount++;
      }
      now = currentBackPressTime;
    });

    if ((touchCount >= 7) || (score == finalScore)) {
      Navigator.pop(context);
    }
  }

  // Score button methods ======================================================
  void setFinalScore(int newScore) {
    setState(() {
      finalScore = newScore;
    });
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

  void checkEndGame() {
    score == finalScore ? gameFinished() : gameNotFinished();
  }

  void gameFinished() {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Juego terminado",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              /// The body of the dialog.
              const Text(
                "¡Enhorabuena! Lo has conseguido",
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),

              /// An ElevatedButton that can be used to close the dialog or perform another action.
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cerrar"),
              ),
            ],
          ),
        ),
      ),
    );
    stopTimer();
  }

  void gameNotFinished() {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Juego no terminado",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              /// The body of the dialog.
              const Text(
                "¡Todavía no has terminado!",
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
  }

  // Time card methods =========================================================
  String twoDigits(int n) => n.toString().padLeft(2, '0');

  void addTime() {
    const addSeconds = 1;

    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      duration = Duration(seconds: seconds);
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void stopTimer() {
    timer?.cancel();
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
}
