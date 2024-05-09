import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:trabajo_fin_grado/models/match.dart';
import 'package:trabajo_fin_grado/providers/match_provider.dart';
import 'package:trabajo_fin_grado/utils/json_util.dart';

class MatchTheSilhouetteBoard extends StatefulWidget {
  const MatchTheSilhouetteBoard({super.key});

  @override
  State<MatchTheSilhouetteBoard> createState() =>
      _MatchTheSilhouetteBoardState();
}

class _MatchTheSilhouetteBoardState extends State<MatchTheSilhouetteBoard> {
  // Pop control variables
  int touchCount = 0;
  DateTime lastBackPress = DateTime.now();
  DateTime currentBackPress = DateTime.now();

  // Score control variables
  int hits = 0;
  int errors = 0;
  final int totalHits = 3;

  // Timer variables
  Duration duration = const Duration();
  Timer? timer;

  // Game visuals variables
  final audioPlayer = AudioPlayer();

  late Map<String, dynamic> level1;
  late Map<String, dynamic> level2;
  late Map<String, dynamic> level3;
  late Map<String, dynamic> currentLevel;
  List<Widget> silhouetteButtons = [];

  @override
  void initState() {
    super.initState();

    level1 = {};
    level2 = {};
    level3 = {};

    // read config json file
    const String configPath = "assets/json/match_the_silhouette.json";
    late Map<String, dynamic> configJson;

    loadJson(path: configPath).then((value) {
      configJson = value;
      List levels = configJson['levels'] as List;

      // choose three random levels from the ones on the file
      List<Map<String, dynamic>> randomLevels = [];
      Random random = Random();

      for (int i = 0; i < 3; i++) {
        int randomIndex = random.nextInt(levels.length);
        Map<String, dynamic> randomLevel = levels[randomIndex];
        randomLevels.add(randomLevel);
        levels.removeAt(randomIndex);
      }

      level1 = randomLevels[0];
      level2 = randomLevels[1];
      level3 = randomLevels[2];

      currentLevel = getCurrentLevel();

      // Create a silhouetteButton for each level
      silhouetteButtons.add(silhouetteButton(level1));
      silhouetteButtons.add(silhouetteButton(level2));
      silhouetteButtons.add(silhouetteButton(level3));

      // Shuffle the list
      silhouetteButtons.shuffle();
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
    final String minutes = twoDigits(duration.inMinutes.remainder(60));
    final String seconds = twoDigits(duration.inSeconds.remainder(60));

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => invokePop(context),
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
          title: const Text("¡A jugar!"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [const Icon(Icons.thumb_up), Text("\t$hits")],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.timer),
                  Text("\t$minutes:$seconds")
                ],
              ),
            ),
          ],
        ),
        body: SafeArea(
            child: Column(
          children: [
            // Imagen
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  currentLevel["colorPath"],
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Botones
            Row(
              children: silhouetteButtons,
            ),
          ],
        )),
      ),
    );
  }

  // Exit from app
  void invokePop(BuildContext context) {
    setState(() {
      currentBackPress = DateTime.now();

      if (currentBackPress.difference(lastBackPress) >
          const Duration(seconds: 2)) {
        touchCount = 1;
      } else {
        touchCount++;
      }
      lastBackPress = currentBackPress;
    });

    if ((touchCount >= 7) || (hits == totalHits)) {
      Navigator.pop(context);
    }
  }

  Future<void> increaseHits() async {
    setState(() {
      hits++;
    });
    await audioPlayer.play(
      AssetSource('sfx/607207__fupicat__congrats.wav'),
    );
  }

  Future<void> increaseErrors() async {
    setState(() {
      errors++;
    });
  }

  bool checkEndGame() => hits == totalHits;

  // Timer control
  String twoDigits(int n) => n.toString().padLeft(2, '0');

  void addTime() {
    setState(() {
      duration = Duration(seconds: duration.inSeconds + 1);
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void stopTimer() {
    timer?.cancel();
  }

  // Game Visuals control
  Future<void> endGame() async {
    stopTimer();
    await audioPlayer.play(
      AssetSource('sfx/607207__fupicat__congrats.wav'),
    );
    Match match = Match(
      gameId: 2,
      createdOn: DateTime.now(),
      duration: duration.inSeconds,
      hits: hits,
      errors: errors,
    );
    await MatchProvider().create(match: match);
    // TODO: navigate to result screen
  }

  Map<String, dynamic> getCurrentLevel() {
    switch (hits) {
      case 0:
        return level1;
      case 1:
        return level2;
      case 2:
        return level3;
      default:
        return {};
    }
  }

  Widget silhouetteButton(Map<String, dynamic> level) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            if (level == getCurrentLevel()) {
              increaseHits();
              setState(() {
                if (checkEndGame()) {
                  endGame();
                } else {
                  currentLevel = getCurrentLevel();
                }
              });
            } else {
              increaseErrors();
            }
          },
          child: Image.asset(
            level["silhouettePath"],
            height: 150,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
