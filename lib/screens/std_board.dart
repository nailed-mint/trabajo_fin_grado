import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:trabajo_fin_grado/models/match.dart';
import 'package:trabajo_fin_grado/providers/match_provider.dart';
import 'package:trabajo_fin_grado/utils/json_util.dart';
import 'package:trabajo_fin_grado/widgets/invisible_button.dart';

class SpotTheDifferenceBoard extends StatefulWidget {
  const SpotTheDifferenceBoard({super.key});

  @override
  State<SpotTheDifferenceBoard> createState() => _SpotTheDifferenceBoardState();
}

class _SpotTheDifferenceBoardState extends State<SpotTheDifferenceBoard> {
  // Pop control variables
  int touchCount = 0;
  DateTime lastBackPress = DateTime.now();
  DateTime currentBackPress = DateTime.now();

  // Score control variables
  int hits = 0;
  int errors = 0;
  late int totalHits;

  // Timer variables
  Duration duration = const Duration();
  Timer? timer;

  // Game visuals variables
  final audioPlayer = AudioPlayer();

  late List<Widget> imageA;
  late List<Widget> imageB;
  late List<Positioned> invisibleButtons;

  @override
  void initState() {
    super.initState();

    imageA = [];
    imageB = [];
    invisibleButtons = [];

    // read config json file
    const String configPath = "assets/json/spot_the_difference.json";
    late Map<String, dynamic> configJson;
    late Map<String, dynamic> chosenLevel;

    loadJson(path: configPath).then((value) {
      configJson = value;
      List levels = configJson['levels'] as List;

      // choose one random level from the ones on the file
      int randomNumber = Random().nextInt(levels.length);
      chosenLevel = levels[randomNumber];

      // set final score (totalHits)
      setTotalHits(chosenLevel['differences'].length);

      // instantiate the difference widgets
      const String imageBasePath = "assets/img/std/";

      imageA = [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: increaseErrors,
            child: Image.asset(
              imageBasePath + chosenLevel['imageA'],
              width: MediaQuery.of(context).size.width * 0.6,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ];

      invisibleButtons = List.generate(
        chosenLevel['differences'].length,
        (index) => Positioned(
          top: chosenLevel['differences'][index]['top'].toDouble(),
          left: chosenLevel['differences'][index]['left'].toDouble(),
          child: InvisibleButton(
            onButtonPressed: increaseHits,
          ),
        ),
      );

      imageB = [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => wrongImageDialog(context),
              );
            },
            child: Image.asset(
              imageBasePath + chosenLevel['imageB'],
              width: MediaQuery.of(context).size.width * 0.6,
              fit: BoxFit.cover,
            ),
          ),
        )
      ];
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
          child: Expanded(
            child: Center(
              child: Column(
                children: [
                  Stack(children: imageA + invisibleButtons),
                  Stack(children: imageB),
                ],
              ),
            ),
          ),
        ),
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

  // Score control
  void setTotalHits(int newScore) {
    setState(() {
      totalHits = newScore;
    });
  }

  Future<void> increaseHits() async {
    setState(() {
      hits++;
    });

    checkEndGame()
        ? await endGame()
        : await audioPlayer.play(
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
  Dialog wrongImageDialog(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Aquí no",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              "Hay que pulsar la imagen de arriba",
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Volver al juego"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> endGame() async {
    await audioPlayer.play(
      AssetSource('sfx/607207__fupicat__congrats.wav'),
    );
    Match match = Match(
      gameId: 1,
      duration: duration.inSeconds,
      hits: hits,
      errors: errors,
    );
    await MatchProvider().create(match: match);
    // TODO: navigate to result screen
  }
}




// 04-03-2024: solo quiero dejar de sentirme completamente miserable con este proyecto, es tanto pedir?