import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:trabajo_fin_grado/View/games/widgets/time_spent_card.dart';

class ScoreDisplay extends StatefulWidget {
  final TimeSpentCardState timeSpentCardState;

  const ScoreDisplay({
    super.key,
    required this.timeSpentCardState,
  });

  @override
  ScoreDisplayState createState() => ScoreDisplayState();
}

class ScoreDisplayState extends State<ScoreDisplay> {
  final player = AudioPlayer();

  int score = 0;
  int errors = 0;
  int finalScore = double.infinity.toInt();

  @override
  Widget build(BuildContext context) {
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
                "¡Enhorabuena! Has encontrado todas las diferencias",
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
    widget.timeSpentCardState.stopTimer();
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
                "Todavía te faltan diferencias por encontrar",
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
}
