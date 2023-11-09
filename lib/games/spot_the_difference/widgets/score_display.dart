import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../spot_the_difference.dart';

/// A StatelessWidget that displays the score of the SpotTheDifference game.
class ScoreDisplay extends StatelessWidget {
  /// Creates a new instance of ScoreDisplay.
  const ScoreDisplay({super.key, required this.game});

  /// The game whose score is to be displayed.
  final Game game;

  /// Builds the widget.
  ///
  /// Returns a ValueListenableBuilder that listens to the score of the game and displays it in a Card.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      /// The ValueListenable that the builder is listening to.
      valueListenable: (game as SpotTheDifference).gameManager.score,

      /// The builder function that is called when the value of the ValueListenable changes.
      builder: (context, value, child) {
        return Card(
          /// The color of the Card.
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Padding(
            /// The padding around the Text widget.
            padding: const EdgeInsets.all(8.0),

            /// The text displayed in the Text widget.
            child: Text(
              'Score: $value',

              /// The style of the text.
              style: Theme.of(context).textTheme.displaySmall!,
            ),
          ),
        );
      },
    );
  }
}
