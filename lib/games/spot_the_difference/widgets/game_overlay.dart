import 'dart:io';

import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:trabajo_fin_grado/games/spot_the_difference/spot_the_difference.dart';
import 'widgets.dart';

/// A StatefulWidget that displays the game overlay for the SpotTheDifference game.
class GameOverlay extends StatefulWidget {
  /// Creates a new instance of GameOverlay.
  const GameOverlay(this.game, {super.key});

  /// The game whose overlay is to be displayed.
  final Game game;

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<GameOverlay> createState() => _GameOverlayState();
}

/// The logic and internal state for a StatefulWidget.
class _GameOverlayState extends State<GameOverlay> {
  /// Whether the game is paused.
  bool isPaused = false;

  /// Whether the game is running on a mobile device.
  final bool isMobile = !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  /// Builds the widget.
  ///
  /// Returns a Material widget with a Stack of widgets that make up the game overlay.
  @override
  Widget build(BuildContext context) {
    return Material(
      /// The color of the Material widget.
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned(
            /// The position of the ScoreDisplay widget from the top of the Stack.
            top: 30,

            /// The position of the ScoreDisplay widget from the left of the Stack.
            left: 30,
            child: ScoreDisplay(game: widget.game),
          ),
          Positioned(
            /// The position of the ElevatedButton widget from the top of the Stack.
            top: 30,

            /// The position of the ElevatedButton widget from the right of the Stack.
            right: 30,
            child: ElevatedButton(
              child: isPaused
                  ? const Icon(
                      /// The icon displayed in the ElevatedButton when the game is paused.
                      Icons.play_arrow,

                      /// The size of the icon.
                      size: 48,
                    )
                  : const Icon(
                      /// The icon displayed in the ElevatedButton when the game is playing.
                      Icons.pause,

                      /// The size of the icon.
                      size: 48,
                    ),
              onPressed: () {
                /// The function that is called when the ElevatedButton is pressed.
                /// It toggles the pause state of the game and updates the isPaused state.
                (widget.game as SpotTheDifference).togglePauseState();
                setState(
                  () {
                    isPaused = !isPaused;
                  },
                );
              },
            ),
          ),
          if (isPaused)
            Positioned(
              /// The position of the Icon widget from the top of the Stack.
              top: MediaQuery.of(context).size.height / 2 - 72.0,

              /// The position of the Icon widget from the right of the Stack.
              right: MediaQuery.of(context).size.width / 2 - 72.0,
              child: const Icon(
                /// The icon displayed in the Icon widget.
                Icons.pause_circle,

                /// The size of the icon.
                size: 144.0,

                /// The color of the icon.
                color: Colors.black12,
              ),
            ),
        ],
      ),
    );
  }
}
