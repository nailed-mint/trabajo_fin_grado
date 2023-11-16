import 'package:flutter/material.dart';

/// A StatelessWidget that displays the score of the SpotTheDifference game.
class ScoreDisplay extends StatelessWidget {
  final ValueNotifier<int> _score = ValueNotifier<int>(0);
  // final Widget goodJob = const Text("¡Bien hecho!");

  ScoreDisplay({super.key});

  /// Builds the widget.
  ///
  /// Returns a ValueListenableBuilder that listens to the score of the game and displays it in a Card.
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text("Score: "),
          ValueListenableBuilder<int>(
            builder: (BuildContext context, int value, Widget? child) {
              // This builder will only get called when the _score is updated
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("$value"),
                  // child!,
                ],
              );
            },
            valueListenable: _score,
            // child: goodJob,
          )
        ],
      ),
    );
  }
}
