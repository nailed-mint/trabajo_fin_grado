import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../spot_the_difference.dart';

class ScoreDisplay extends StatelessWidget {
  const ScoreDisplay({super.key, required this.game});

  final Game game;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: (game as SpotTheDifference).gameManager.score,
      builder: (context, value, child) {
        return Card(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Score: $value',
              style: Theme.of(context).textTheme.displaySmall!,
            ),
          ),
        );
      },
    );
  }
}
