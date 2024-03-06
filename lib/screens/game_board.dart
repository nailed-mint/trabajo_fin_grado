import 'dart:async';

import 'package:flutter/material.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  // Pop control variables
  int touchCount = 0;
  DateTime lastBackPress = DateTime.now();
  DateTime currentBackPress = DateTime.now();

  // Score control variables
  int hits = 0;
  int errors = 0;
  int? totalHits;

  // Timer variables
  Duration duration = const Duration();
  Timer? timer;

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
              child: Row(children: [
                const Icon(Icons.timer),
                Text("\t$minutes:$seconds")
              ]),
            ),
          ],
        ),
        body: const Center(child: Text("Juego no encontrado")),
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

    // TODO: check end game

    // TODO: play hit sfx
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
}
