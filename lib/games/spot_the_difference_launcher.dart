import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import './spot_the_difference/spot_the_difference.dart';
import './spot_the_difference/widgets/widgets.dart';

/// A StatelessWidget that launches the SpotTheDifference game.
class SpotTheDifferenceScreen extends StatelessWidget {
  /// Creates a new instance of SpotTheDifferenceScreen.
  const SpotTheDifferenceScreen({super.key});

  /// Builds the widget.
  ///
  /// Returns a SpotTheDifferenceLauncher widget with the title "Spot the Difference".
  @override
  Widget build(BuildContext context) {
    return const SpotTheDifferenceLauncher(title: "Spot the Difference");
  }
}

/// The SpotTheDifference game instance.
final Game game = SpotTheDifference();

/// A StatefulWidget that launches the SpotTheDifference game.
class SpotTheDifferenceLauncher extends StatefulWidget {
  /// Creates a new instance of SpotTheDifferenceLauncher.
  const SpotTheDifferenceLauncher({super.key, required this.title});

  /// The title of the game.
  final String title;

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<SpotTheDifferenceLauncher> createState() =>
      _SpotTheDifferenceLauncherState();
}

/// The logic and internal state for a StatefulWidget.
class _SpotTheDifferenceLauncherState extends State<SpotTheDifferenceLauncher> {
  /// Builds the widget.
  ///
  /// Returns a Scaffold with a GameWidget in the center.
  /// The GameWidget displays the SpotTheDifference game and its overlays.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// The background color of the Scaffold.
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              constraints: const BoxConstraints(
                /// The maximum width of the Container.
                maxWidth: 800,

                /// The minimum width of the Container.
                minWidth: 550,
              ),
              child: GameWidget(
                /// The game to be displayed in the GameWidget.
                game: game,

                /// The map of overlay builders for the GameWidget.
                ///
                /// Each overlay builder is a function that takes a BuildContext
                ///  and a Game and returns a Widget.
                overlayBuilderMap: <String,
                    Widget Function(BuildContext, Game)>{
                  /// The overlay builder for the game overlay.
                  "gameOverlay": (context, game) => GameOverlay(game),

                  /// The overlay builder for the intro overlay.
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
