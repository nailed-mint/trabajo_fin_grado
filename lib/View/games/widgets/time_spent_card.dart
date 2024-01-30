import 'dart:async';

import 'package:flutter/material.dart';

/// Este Widget se usa para mostrar el tiempo transcurrido desde que se inició la partida
class TimeSpentCard extends StatefulWidget {
  const TimeSpentCard({super.key});

  @override
  TimeSpentCardState createState() => TimeSpentCardState();
}

class TimeSpentCardState extends State<TimeSpentCard> {
  Duration duration = const Duration();
  Timer? timer;

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

  @override
  Widget build(BuildContext context) {
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
}
