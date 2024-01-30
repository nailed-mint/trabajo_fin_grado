import 'package:flutter/material.dart';

/// Este Widget se usa para abandonar el juego
/// Para ello, debe pulsarse 5 veces seguidas
/// Cada pulsación no debe tardar más de 2 segundos desde la anterior o,
/// de lo contrario, el contador se reiniciará
Widget exitButton(BuildContext context) {
  int touchCount = 0;
  DateTime now = DateTime.now();
  DateTime currentBackPressTime = DateTime.now();

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

  return Card(
    margin: const EdgeInsets.all(8),
    child: TextButton(
      onPressed: invokePop,
      child: const Icon(Icons.arrow_back, size: 30),
    ),
  );
}
