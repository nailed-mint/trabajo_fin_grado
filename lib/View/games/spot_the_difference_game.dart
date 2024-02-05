import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'package:trabajo_fin_grado/Controller/shared.dart';
import 'package:trabajo_fin_grado/View/games/spot_the_difference/widgets/invisible_button.dart';

class SpotTheDifference extends StatefulWidget {
  const SpotTheDifference({super.key});

  @override
  SpotTheDifferenceState createState() => SpotTheDifferenceState();
}

class SpotTheDifferenceState extends State<SpotTheDifference> {
  // Exit button attributes
  int touchCount = 0;
  DateTime now = DateTime.now();
  DateTime currentBackPressTime = DateTime.now();
  // Score button attributes
  final player = AudioPlayer();
  int score = 0;
  int errors = 0;
  late int finalScore; // Must be changed to fit game level needs
  // Time Card attributes
  Duration duration = const Duration();
  Timer? timer;
  // Game attributes
  String path = 'assets/config/spot_the_difference.json';
  late String pathImageA;
  late String pathImageB;
  late List<Widget> childWithButtons;
  late List<Widget> childWithoutButtons;
  late List<Positioned> differenceButtons;

  @override
  void initState() {
    super.initState();
    childWithButtons = [];
    childWithoutButtons = [];
    differenceButtons = [];

    //Choosing the game level
    // STEP 1: READ CONFIG FILE
    late Map<String, dynamic> config;
    late dynamic randomLevel;

    loadJson(path: path).then((value) {
      config = value;
      List levels = config["levels"] as List;

      // STEP 2: CHOOSE RANDOM LEVEL
      var random = Random();
      var randomIndex = random.nextInt(levels.length);

      randomLevel = levels[randomIndex];

      // STEP 3: ESTABLISH FINAL SCORE
      setFinalScore(randomLevel["differences"].length);

      // STEP 4: CREATE DIFFERENCE WIDGET
      pathImageA = randomLevel["pathImageA"];
      pathImageB = randomLevel["pathImageB"];

      childWithoutButtons = [
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
                        const Text(
                          "Aquí no",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Hay que pulsar la imagen de arriba",
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 16),
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

      childWithButtons = [
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
        )
      ];

      differenceButtons = List.generate(
        randomLevel["differences"].length,
        (index) => Positioned(
          top: randomLevel["differences"][index]["top"].toDouble(),
          left: randomLevel["differences"][index]["left"].toDouble(),
          child: InvisibleButton(
            onButtonPressed: increaseScore,
          ),
        ),
      );

      finalScore = differenceButtons.length;
    });
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();

    stopTimer();
  }

  @override
  Widget build(BuildContext context) {
    // Timer variables
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
              Expanded(
                child: Center(
                  child: Column(
                    children: [
                      Stack(children: childWithButtons + differenceButtons),
                      Stack(children: childWithoutButtons),
                    ],
                  ),
                ),
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
              const Text(
                "¡Enhorabuena! Has conseguido encontrar todas las diferencias",
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),
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
              Text(
                "Todavía te quedan ${finalScore - score} diferencias por encontrar",
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),
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
}
