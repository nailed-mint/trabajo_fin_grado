import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import './spot_the_difference/spot_the_difference.dart';
import './spot_the_difference/widgets/widgets.dart';

class SpotTheDifferenceScreen extends StatelessWidget {
  const SpotTheDifferenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Spot the difference',
      home: SpotTheDifferenceLauncher(
        title: 'Spot The Difference',
      ),
    );
  }
}

final Game game = SpotTheDifference();

class SpotTheDifferenceLauncher extends StatefulWidget {
  const SpotTheDifferenceLauncher({super.key, required this.title});
  final String title;
  @override
  State<SpotTheDifferenceLauncher> createState() =>
      _SpotTheDifferenceLauncherState();
}

class _SpotTheDifferenceLauncherState extends State<SpotTheDifferenceLauncher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              constraints: const BoxConstraints(
                maxWidth: 800,
                minWidth: 550,
              ),
              child: GameWidget(
                game: game,
                overlayBuilderMap: <String,
                    Widget Function(BuildContext, Game)>{
                  "gameOverlay": (context, game) => GameOverlay(game),
                  "introOverlay": (context, game) => IntroOverlay(game),
                  // 'scoreOverlay': (context, gameRef) => ScoreOverlay(gameRef),
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
